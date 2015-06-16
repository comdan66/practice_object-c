//
//  ViewController.m
//  OA_1.5
//
//  Created by OA Wu on 2015/6/16.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginButton:(id)sender {
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Loading..." message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [myAlertView show];
    
    MyHttp *http = [MyHttp new];
    NSMutableDictionary *vars = [NSMutableDictionary new];
    [vars setObject:self.accountTextField.text forKey:@"account"];
    [vars setObject:self.passwordTextField.text forKey:@"password"];
    
    [http postURL:@"http://ios.ioa.tw/api/login" vars: vars completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSString *title = [[NSString alloc] initWithFormat:[[result objectForKey:@"status"] boolValue] ? @"登入成功！" : @"登入失敗！"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [myAlertView dismissWithClickedButtonIndex:-1 animated:YES];

            UIAlertView *ok = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
            [ok show];
        });
    }];
    
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    [alertView dismissWithClickedButtonIndex:-1 animated:YES];

    if ([alertView.title isEqual:@"登入成功！"]) {
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"logined"];
        [self showDetailViewController:vc sender:self];
    }
}

@end

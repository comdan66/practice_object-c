//
//  ViewController.m
//  AlertView
//
//  Created by OA Wu on 2015/6/12.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Title" message:@"Message" delegate:self cancelButtonTitle:@"確定" otherButtonTitles:@"取消", nil];
    
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    
    [alert show];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    UITextField *accountTextField, *passwordTextField;
    
    switch (buttonIndex) {
            
        case 0:
            accountTextField = [alertView textFieldAtIndex:0];
            passwordTextField = [alertView textFieldAtIndex:1];
            
            NSLog(@"帳號：%@, 密碼：%@", accountTextField.text, passwordTextField.text);
            break;

        case 1:
            NSLog(@"取消登入！");
            break;
    }
}

@end

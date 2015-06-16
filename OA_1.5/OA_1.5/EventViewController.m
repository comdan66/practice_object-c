//
//  EventViewController.m
//  OA_1.5
//
//  Created by OA Wu on 2015/6/16.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "EventViewController.h"

@interface EventViewController () {
    NSString *eventId, *eventTitle;
}

@end

@implementation EventViewController

-(void)backButtonAction  {
    [self.backdelegate updateEvent:eventId title:eventTitle];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)updateButton:(id)sender {
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Loading..." message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [myAlertView show];
    
    MyHttp *http = [MyHttp new];
    NSMutableDictionary *vars = [NSMutableDictionary new];
    [vars setObject:self.idLabel.text forKey:@"id"];
    [vars setObject:self.titleTextField.text forKey:@"title"];
    
    [http getURL:@"http://ios.ioa.tw/api/update_event" vars: vars completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSString *title = [[NSString alloc] initWithFormat:[[result objectForKey:@"status"] boolValue] ? @"更新成功！" : @"更新失敗！"];
        
        if ([[result objectForKey:@"status"] boolValue]) {
            eventId =[[NSString alloc] initWithFormat:@"%@", [[result objectForKey:@"event"] objectForKey:@"id"]];
            eventTitle = [[NSString alloc] initWithFormat:@"%@", [[result objectForKey:@"event"] objectForKey:@"title"]];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *ok = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
            [ok show];

            [myAlertView dismissWithClickedButtonIndex:-1 animated:YES];
        });
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.idLabel.text = eventId;
    self.titleTextField.text = eventTitle;
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Loading..." message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [myAlertView show];
    
    MyHttp *http = [MyHttp new];
    NSMutableDictionary *vars = [NSMutableDictionary new];
    [vars setObject:eventId forKey:@"id"];
    [http getURL:@"http://ios.ioa.tw/api/event" vars: vars completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            eventId =[[NSString alloc] initWithFormat:@"%@", [[result objectForKey:@"event"] objectForKey:@"id"]];
            eventTitle = [[NSString alloc] initWithFormat:@"%@", [[result objectForKey:@"event"] objectForKey:@"title"]];
            
            if ([[result objectForKey:@"status"] boolValue]) {
                self.idLabel.text = eventId;
                self.titleTextField.text = eventTitle;
            } else {
                [self.navigationController popViewControllerAnimated:YES];
            }
        
            [myAlertView dismissWithClickedButtonIndex:-1 animated:YES];
        });
        
    }];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] init];
    [self.navigationItem.leftBarButtonItem setTitle:@"❮ Back"];
    [self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStyleDone];
    [self.navigationItem.leftBarButtonItem setTarget:self];
    [self.navigationItem.leftBarButtonItem setAction:@selector(backButtonAction)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)prassEventId:(NSString *)id title:(NSString *)title {
    eventId = [[NSString alloc] initWithFormat:@"%@", id];
    eventTitle = [[NSString alloc] initWithFormat:@"%@", title];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

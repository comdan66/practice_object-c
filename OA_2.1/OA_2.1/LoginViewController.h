//
//  ViewController.h
//  OA_2.1
//
//  Created by OA Wu on 2015/6/23.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPRequestOperationManager.h"
#import "RegisterViewController.h"
#import "RegisterDelegate.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate, RegisterDelegate>

@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *verticalDividerLabel;

@end


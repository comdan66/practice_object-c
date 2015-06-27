//
//  ViewController.m
//  OA_2.1
//
//  Created by OA Wu on 2015/6/23.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "LoginViewController.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.accountTextField setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:.5]];
    [self.accountTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.accountTextField.layer setBorderColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:.1].CGColor];
    [self.accountTextField.layer setBorderWidth:1.0f / [UIScreen mainScreen].scale];
    [self.accountTextField.layer setCornerRadius:4];
    [self.accountTextField setKeyboardType:UIKeyboardTypeASCIICapable];
    [self.accountTextField setDelegate:self];

    [self.passwordTextField setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:.5]];
    [self.passwordTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordTextField.layer setBorderColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:.1].CGColor];
    [self.passwordTextField.layer setBorderWidth:1.0f / [UIScreen mainScreen].scale];
    [self.passwordTextField.layer setCornerRadius:4];
    [self.passwordTextField setKeyboardType:UIKeyboardTypeASCIICapable];
    [self.passwordTextField setDelegate:self];
    
    if ([USER_DEFAULTS objectForKey:@"user"]) {
        [self.accountTextField setText:[[USER_DEFAULTS objectForKey:@"user"] objectForKey:@"account"]];
    }
    
    [self.verticalDividerLabel setBackgroundColor:[UIColor colorWithRed:0.76 green:0.76 blue:0.79 alpha:0.3]];
    
    [self.registerButton.layer setBackgroundColor:[UIColor colorWithRed:233.0/255.0 green:234.0/255.0 blue:237.0/255.0 alpha:.2].CGColor];
    [self.registerButton.layer setCornerRadius:3];
    
    [self.loginButton.layer setBackgroundColor:[UIColor colorWithRed:233.0/255.0 green:234.0/255.0 blue:237.0/255.0 alpha:.2].CGColor];
    [self.loginButton.layer setCornerRadius:3];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(touchesBegan)];
    tapGesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGesture];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.accountTextField) {
        [self.accountTextField resignFirstResponder];
        
        if ([self.passwordTextField.text length] <= 0) {
            [self.passwordTextField becomeFirstResponder];
        }
    } else if (textField == self.passwordTextField) {
        [self.passwordTextField resignFirstResponder];
    } else {
        [self.accountTextField resignFirstResponder];
        [self.passwordTextField resignFirstResponder];
    }
    
    return YES;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"registerSegue"]) {
        RegisterViewController *registerVC = segue.destinationViewController;
        registerVC.loginVC = self;
    }
}
-(void)updateAccount:(NSString *) account {
    [self.accountTextField setText:account];
    [self.passwordTextField becomeFirstResponder];
}


- (void)touchesBegan {
    [self textFieldShouldReturn: [UITextField new]];
}
- (IBAction)loginButtonAction:(id)sender {
    if (![self checkData])
        return;
    
    UIAlertView *loadingAlert = [[UIAlertView alloc] initWithTitle:@"Loading..."
                                                           message:nil
                                                          delegate:self
                                                 cancelButtonTitle:nil
                                                 otherButtonTitles:nil, nil];
    [loadingAlert show];
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc]init];
    [data setValue:self.accountTextField.text forKey:@"account"];
    [data setValue:self.passwordTextField.text forKey:@"password"];
        
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"application/json"]];
    [manager POST:[NSString stringWithFormat:@"http://ios.ioa.tw/api/v1/login"]
       parameters:data
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              [loadingAlert dismissWithClickedButtonIndex:-1 animated:YES];
              if ([[responseObject objectForKey:@"status"] boolValue]) {
                  [USER_DEFAULTS setValue:[responseObject objectForKey:@"user"] forKey:@"user"];
                  [USER_DEFAULTS setValue:@"YES" forKey:@"isLogin"];
                  [self performSegueWithIdentifier:@"loginSegue" sender:self];
              } else {
                  [[[UIAlertView alloc] initWithTitle:@"失敗"
                                              message:[responseObject objectForKey:@"message"]
                                             delegate:self
                                    cancelButtonTitle:nil
                                    otherButtonTitles:nil, nil] show];
              
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [[[UIAlertView alloc] initWithTitle:@"提示"
                                          message:@"連線註冊失敗，請確認網路連線狀況後再試一次..."
                                         delegate:self
                                cancelButtonTitle:nil
                                otherButtonTitles:nil, nil] show];
          }
    ];
}

- (BOOL)checkData {
    if ([self.accountTextField.text length] <= 0) {
        UIAlertView *AlertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"請輸入帳號喔！"
                                                           delegate:self
                                                  cancelButtonTitle:@"確定"
                                                  otherButtonTitles:nil, nil];
        [AlertView show];
        return NO;
    }
    if ([self.passwordTextField.text length] <= 0) {
        UIAlertView *AlertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"請輸入密碼喔！"
                                                           delegate:self
                                                  cancelButtonTitle:@"確定"
                                                  otherButtonTitles:nil, nil];
        [AlertView show];
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

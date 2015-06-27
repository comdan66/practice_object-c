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

    [self.passwordTextField setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:.5]];
    [self.passwordTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordTextField.layer setBorderColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:.1].CGColor];
    [self.passwordTextField.layer setBorderWidth:1.0f / [UIScreen mainScreen].scale];
    [self.passwordTextField.layer setCornerRadius:4];
    [self.passwordTextField setKeyboardType:UIKeyboardTypeASCIICapable];
    
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.accountTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];

    return YES;
}

- (void)touchesBegan {
    [self textFieldShouldReturn: [UITextField new]];
}
- (IBAction)loginButtonAction:(id)sender {
    [self performSegueWithIdentifier:@"loginSegue" sender:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

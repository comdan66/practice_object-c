//
//  ViewController.m
//  OA_2.1
//
//  Created by OA Wu on 2015/6/23.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.registerButton.layer setBackgroundColor:[UIColor colorWithRed:233.0/255.0 green:234.0/255.0 blue:237.0/255.0 alpha:.2].CGColor];
    [self.registerButton.layer setCornerRadius:3];
    
    [self.loginButton.layer setBackgroundColor:[UIColor colorWithRed:233.0/255.0 green:234.0/255.0 blue:237.0/255.0 alpha:.2].CGColor];
    [self.loginButton.layer setCornerRadius:3];
    
    [self.accountTextField setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:.5]];
    [self.accountTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.accountTextField.layer setBorderColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:.1].CGColor];
    [self.accountTextField.layer setBorderWidth:1.5f];
    [self.accountTextField.layer setCornerRadius:4];

    [self.passwordTextField setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:.5]];
    [self.passwordTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordTextField.layer setBorderColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:.1].CGColor];
    [self.passwordTextField.layer setBorderWidth:1.5f];
    [self.passwordTextField.layer setCornerRadius:4];

    
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


//    [self.registerButton.layer setBorderColor:[UIColor colorWithRed:39.0/255.0 green:40.0/255.0 blue:34.0/255.0 alpha:0.4].CGColor];
//[cell.avatarView.layer setBorderWidth:1.0f];
//[cell.avatarView.layer setCornerRadius:35];
//[cell.avatarView.layer setShadowColor:[UIColor colorWithRed:39.0/255.0 green:40.0/255.0 blue:34.0/255.0 alpha:1].CGColor];
//[cell.avatarView.layer setShadowOffset:CGSizeMake(2.4f, 2.0f)];
//[cell.avatarView.layer setShadowRadius:5.0f];
//[cell.avatarView.layer setShadowOpacity:0.5f];

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

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
    // Do any additional setup after loading the view, typically from a nib.
//    UIImage *img = [UIImage imageNamed:@"upload.jpg"];
//    
//    NSData *imageData = UIImageJPEGRepresentation(img,0.2);
//    
//    //上傳所需資訊
//    NSMutableDictionary *data = [[NSMutableDictionary alloc]init];
//    [data setValue:@"xxx" forKey:@"text"];
//
//    //上傳網址
//    NSString *urlString = [NSString stringWithFormat:@"http://ios.ioa.tw/api/v1/test"];
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
//    
//    [manager POST:urlString parameters:data constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
//            [formData appendPartWithFileData:imageData name:@"file" fileName:@"fg.jpg" mimeType:@"image/jepg"];
//        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSLog(@"responseObject : %@",responseObject);
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            NSLog(@"圖片上傳error=%@",error);
//        }
//     ];
//    
//    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//    
//    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//    
//    visualEffectView.frame = self.bgImageView.bounds;
//    
//    [self.bgImageView addSubview:visualEffectView];
//    
//    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_bg.jpg"]];
//    imgView.frame = self.view.bounds;
//    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    imgView.contentMode = UIViewContentModeScaleAspectFill;

//    [self.view addSubview:self.bgImageView];
//    [self.view sendSubviewToBack:self.bgImageView];
////
//    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//    visualEffectView.frame = self.bgImageView.bounds;
//    [self.bgImageView addSubview:visualEffectView];
    
//    UIImage* _backGround = [UIImage imageNamed:@"login_bg.jpg"];
//    UIImageView* _backGroundView = [[UIImageView alloc] initWithImage:_backGround];
//    
//    _backGroundView.frame = self.view.frame;
//    _backGroundView.contentMode = UIViewContentModeScaleAspectFill;
//    
//    [self.view addSubview:_backGroundView];
//    [self.view sendSubviewToBack:_backGroundView];

//    UIGraphicsBeginImageContext(self.view.frame.size);
//    [[UIImage imageNamed:@"login_bg.jpg"] drawInRect:self.view.bounds];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
//    
//    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
////    visualEffectView.frame = self.bounds;
//////    self.b
//    [self.bgImageView addSubview:visualEffectView];

//    [self.bgImageView.layer setBorderColor:[UIColor redColor].CGColor];
//    [self.bgImageView.layer setBorderWidth:1.0f];
//    [self.bgImageView setClipsToBounds:YES];

    
//    [self.bgImageView addSubview:bgVisualEffectView];
    
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

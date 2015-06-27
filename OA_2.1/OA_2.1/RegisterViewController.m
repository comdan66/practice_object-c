//
//  RegisterViewController.m
//  OA_2.1
//
//  Created by OA Wu on 2015/6/24.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController () {
    UIImagePickerController *imagePickerController;
    BOOL hasChoiceAvatar;
    CGFloat viewAddHeight;
    UITextField *focusTextField;

}
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    UIButton *button = [[UIButton alloc] init];
//    
//    // 設定按鈕的類型
//    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    // 設定按鈕的位置與大小
//    button.frame = CGRectMake(20.0, 20.0, 100.0, 40.0);
//    // 設定按鈕上的文字
//    [button setTitle:@"Push Me" forState:UIControlStateNormal];
//    // 攔截按鈕按下去的訊息，並觸發buttonPress:方法
//    [button addTarget:self action:@selector(buttonPress) forControlEvents:UIControlEventTouchUpInside];
//    // 將按鈕加進目前的畫面上
//    [self.view addSubview:button];
    
    [self.avatarImageView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.avatarImageView.layer setBorderWidth:2.0f];
    [self.avatarImageView.layer setCornerRadius:75];
    [self.avatarImageView.layer setMasksToBounds:YES];
    [self.avatarImageView setBackgroundColor:[UIColor colorWithRed:236.0/255.0 green:140.0/255.0 blue:113.0/255.0 alpha:.3]];
    
    [self.nameTextField setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:.35]];
    [self.nameTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.nameTextField.layer setBorderColor:[UIColor clearColor].CGColor];
    [self.nameTextField.layer setBorderWidth:1.0f / [UIScreen mainScreen].scale];
    [self.nameTextField.layer setCornerRadius:4];    
    [self.nameTextField setDelegate:self];

    [self.accountTextField setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:.35]];
    [self.accountTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.accountTextField.layer setBorderColor:[UIColor clearColor].CGColor];
    [self.accountTextField.layer setBorderWidth:1.0f / [UIScreen mainScreen].scale];
    [self.accountTextField.layer setCornerRadius:4];
    [self.accountTextField setDelegate:self];
    [self.accountTextField setKeyboardType:UIKeyboardTypeASCIICapable];

    
    [self.passwordTextField setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:.35]];
    [self.passwordTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordTextField.layer setBorderColor:[UIColor clearColor].CGColor];
    [self.passwordTextField.layer setBorderWidth:1.0f / [UIScreen mainScreen].scale];
    [self.passwordTextField.layer setCornerRadius:4];
    [self.passwordTextField setDelegate:self];
    [self.passwordTextField setKeyboardType:UIKeyboardTypeASCIICapable];

    [self.verticalDividerLabel setBackgroundColor:[UIColor colorWithRed:0.76 green:0.76 blue:0.79 alpha:0.5]];
    
    [self.cancelButton.layer setBackgroundColor:[UIColor colorWithRed:233.0/255.0 green:234.0/255.0 blue:237.0/255.0 alpha:.2].CGColor];
    [self.cancelButton.layer setCornerRadius:3];

    [self.submitButton.layer setBackgroundColor:[UIColor colorWithRed:233.0/255.0 green:234.0/255.0 blue:237.0/255.0 alpha:.2].CGColor];
    [self.submitButton.layer setCornerRadius:3];
    
    [self cleanData];

    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchAvatarImage)];
    singleTap.numberOfTapsRequired = 1;
    [self.avatarImageView setUserInteractionEnabled:YES];
    [self.avatarImageView addGestureRecognizer:singleTap];
    
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(touchesBegan)];
    tapGesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGesture];
    
    
    viewAddHeight = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    focusTextField = textField;
}

- (void)keyboardWillShow:(NSNotification *)notification {
    if (viewAddHeight > 0) {
        return;
    }
    
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    viewAddHeight = keyboardSize.height - (self.scrollView.contentSize.height - (focusTextField.frame.origin.y + focusTextField.frame.size.height));
    viewAddHeight = viewAddHeight < 0 ? 0 : viewAddHeight;
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: 0.3f];
    self.view.frame = CGRectOffset(self.view.frame, 0, 0 - viewAddHeight);
    [UIView commitAnimations];
    
}
- (void)keyboardWillHide:(NSNotification*)notification {
    if (!self.isViewLoaded || !self.view.window) {
        return;
    }
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: 0.3f];
    self.view.frame = CGRectOffset(self.view.frame, 0, viewAddHeight);
    [UIView commitAnimations];
    
    viewAddHeight = 0;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
    
    return newLength <= 200 || returnKey;

    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {

    if (textField == self.nameTextField) {
        [self.nameTextField resignFirstResponder];

        if ([self.accountTextField.text length] <= 0) {
            [self.accountTextField becomeFirstResponder];
        } else if ([self.passwordTextField.text length] <= 0) {
            [self.passwordTextField becomeFirstResponder];
        }
    } else if (textField == self.accountTextField) {
        [self.accountTextField resignFirstResponder];

        if ([self.passwordTextField.text length] <= 0) {
            [self.passwordTextField becomeFirstResponder];
        }
    } else if (textField == self.passwordTextField) {
        [self.passwordTextField resignFirstResponder];
    } else {
        [self.nameTextField resignFirstResponder];
        [self.accountTextField resignFirstResponder];
        [self.passwordTextField resignFirstResponder];
    }
    
    return YES;
}

- (void)touchAvatarImage {
    [self touchesBegan];

    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"請選擇方式"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:@"拍照"
                                  otherButtonTitles:@"選取照片", nil];
    
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self showCamera];
            break;
        case 1:
            [self showPhotoLibrary];
            break;
    }
}
- (void) showCamera {
    imagePickerController = [UIImagePickerController new];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
    imagePickerController.delegate = self;
    imagePickerController.navigationBarHidden = YES;

    imagePickerController.cameraDevice = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront] ? UIImagePickerControllerCameraDeviceFront : UIImagePickerControllerCameraDeviceRear;

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(cameraChangeDevice:)
                                                 name:@"AVCaptureDeviceDidStartRunningNotification"
                                               object:nil];
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}
-(void)cameraChangeDevice:(NSNotification *)notification {
    if(imagePickerController.cameraDevice == UIImagePickerControllerCameraDeviceFront) {
        imagePickerController.cameraViewTransform = CGAffineTransformIdentity;
        imagePickerController.cameraViewTransform = CGAffineTransformScale(imagePickerController.cameraViewTransform, -1, 1);
    } else {
        imagePickerController.cameraViewTransform = CGAffineTransformIdentity;
    }
}
- (void)showPhotoLibrary {
    imagePickerController = [UIImagePickerController new];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [imagePickerController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    imagePickerController.delegate = self;

    [self presentViewController:imagePickerController animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    [self.avatarImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.avatarImageView setImage:image];
    hasChoiceAvatar = YES;

    
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.nameTextField.text length] <= 0) {
            [self.nameTextField becomeFirstResponder];
        } else if ([self.accountTextField.text length] <= 0) {
            [self.accountTextField becomeFirstResponder];
        } else if ([self.passwordTextField.text length] <= 0) {
            [self.passwordTextField becomeFirstResponder];
        }
    }];
}

- (void) cleanData {
    [self touchesBegan];

    [self.avatarImageView setImage:[UIImage imageNamed:@"camera.png"]];
    [self.avatarImageView setContentMode:UIViewContentModeCenter];
    hasChoiceAvatar = NO;
    
    [self.nameTextField setText:@""];
    [self.accountTextField setText:@""];
    [self.passwordTextField setText:@""];
}

- (void)touchesBegan {
    [self textFieldShouldReturn: [UITextField new]];
}
- (IBAction)cancelButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)submitButtonAction:(id)sender {
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
    [data setValue:self.nameTextField.text forKey:@"name"];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"application/json"]];
    [manager POST:[NSString stringWithFormat:@"http://ios.ioa.tw/api/v1/register"]
       parameters:data constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        [formData appendPartWithFileData:UIImageJPEGRepresentation ([ImageUtility fixOrientation:self.avatarImageView.image], 0.1)
                                    name:@"avatar"
                                fileName:@"fg.jpg"
                                mimeType:@"image/jepg"];
        }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              [loadingAlert dismissWithClickedButtonIndex:-1 animated:YES];
            
              if ([[responseObject objectForKey:@"status"] boolValue]) {
                  [[[UIAlertView alloc] initWithTitle:@"成功"
                                              message:@"恭喜，註冊成功，你已經是會員了，趕快登入吧！"
                                     cancelButtonItem:[RIButtonItem itemWithLabel:@"確定" action:^{

                      [USER_DEFAULTS setValue:[responseObject objectForKey:@"user"] forKey:@"user"];
                      
                      [_loginVC updateAccount:[[responseObject objectForKey:@"user"] objectForKey:@"account"]];
                      [self dismissViewControllerAnimated:YES completion:nil];
                  }]
                                     otherButtonItems:nil, nil] show];
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
    if (!hasChoiceAvatar) {
        UIAlertView *AlertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"請挑選或使用相機拍攝一張照片！"
                                                           delegate:self
                                                  cancelButtonTitle:@"確定"
                                                  otherButtonTitles:nil, nil];
        [AlertView show];
        return NO;
    }
    if ([self.nameTextField.text length] <= 0) {
        UIAlertView *AlertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"請輸入暱稱喔！"
                                                           delegate:self
                                                  cancelButtonTitle:@"確定"
                                                  otherButtonTitles:nil, nil];
        [AlertView show];
        return NO;
    }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

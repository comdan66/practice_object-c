//
//  CameraViewController.m
//  OA_2.1
//
//  Created by OA Wu on 2015/6/27.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController () {
    UIImagePickerController *imagePickerController;
    BOOL hasChoiceAvatar;
    CGFloat viewAddHeight;
    CLLocationManager *locationManager;
    CLLocation *location;
}

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    
    locationManager = [CLLocationManager new];
    [locationManager setDelegate:self];
    [locationManager requestWhenInUseAuthorization];
    
    [self.view.layer setBackgroundColor:[UIColor colorWithRed:0.9 green:0.88 blue:0.87 alpha:1].CGColor];
    
    [self.borderView.layer setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor];
    [self.borderView.layer setBorderColor:[UIColor colorWithRed:0.79 green:0.74 blue:0.72 alpha:1.0].CGColor];
    [self.borderView.layer setBorderWidth:1.0f / [UIScreen mainScreen].scale];
    [self.borderView.layer setCornerRadius:5];
    [self.borderView setClipsToBounds:YES];
    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchAvatarImage)];
    singleTap.numberOfTapsRequired = 1;
    [self.pictureImageView setClipsToBounds:YES];
    [self.pictureImageView setUserInteractionEnabled:YES];
    [self.pictureImageView addGestureRecognizer:singleTap];
    

    [self.descriptionTextView setPlaceholder:@"請輸入照片說明..."];
    [self.descriptionTextView setPlaceholderColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.57 alpha:1]];
    [self.descriptionTextView.layer setBorderColor:[UIColor colorWithRed:0.79 green:0.74 blue:0.72 alpha:1.0].CGColor];
    [self.descriptionTextView.layer setBorderWidth:1.0f / [UIScreen mainScreen].scale];
    [self.descriptionTextView.layer setCornerRadius:5];
    [self.descriptionTextView setClipsToBounds:YES];
    [self.descriptionTextView setDelegate:self];
    
    
    [self.submitButton.layer setBorderColor:[UIColor redColor].CGColor];
    [self.submitButton.layer setBorderWidth:1.0f / [UIScreen mainScreen].scale];
    [self.submitButton.layer setCornerRadius:4];
    [self.submitButton setClipsToBounds:YES];
    [self.submitButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    [self.submitButton setTitle:@"確定送出" forState:UIControlStateNormal];

    [self.submitButton setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] forState:UIControlStateNormal];
    [self.submitButton.layer setBackgroundColor:[UIColor colorWithRed:0.91 green:0.37 blue:0.32 alpha:1].CGColor];
    
    
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

    [self cleanData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
//    CLLocation *c = [locations objectAtIndex:0];
    location = [locations objectAtIndex:0];
//
//    NSLog(@"%@", locations);
//    NSLog(@"緯度：%f, 經度：%f, 高度：%f", c.coordinate.latitude, c.coordinate.longitude, c.altitude);
}
-(void)viewDidDisappear:(BOOL)animated {
    [locationManager stopUpdatingLocation];
}

- (void) cleanData {
    [self touchesBegan];
    
    hasChoiceAvatar = NO;

    [self.pictureImageView setImage:[UIImage imageNamed:@"CameraDefaultPicture"]];
    [self.pictureImageView setContentMode:UIViewContentModeCenter];
    
    [self.descriptionTextView setText:@""];
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
    
    imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    
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
    
    [self.pictureImageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.pictureImageView setImage:image];
    hasChoiceAvatar = YES;
    
    
    [self dismissViewControllerAnimated:YES completion: ^ {
        if ([self.descriptionTextView.text length] <= 0) {
            [self.descriptionTextView becomeFirstResponder];
        }
    }];
}
- (void)keyboardWillShow:(NSNotification *)notification {
    if (viewAddHeight > 0) {
        return;
    }
    
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    viewAddHeight = keyboardSize.height - (self.scrollView.contentSize.height - (self.descriptionTextView.frame.origin.y + self.descriptionTextView.frame.size.height));
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

- (void)touchesBegan {
    [self.descriptionTextView resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submitButtonAction:(id)sender {
    [self touchesBegan];
    
    if (![self checkData])
        return;
        
    UIAlertView *loadingAlert = [[UIAlertView alloc] initWithTitle:@"Loading..."
                                                           message:nil
                                                          delegate:self
                                                 cancelButtonTitle:nil
                                                 otherButtonTitles:nil, nil];
    [loadingAlert show];
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc]init];
    [data setValue:self.descriptionTextView.text forKey:@"description"];
    [data setValue:[[USER_DEFAULTS objectForKey:@"user"] objectForKey:@"id"] forKey:@"user_id"];

    if (location != nil) {
        [data setValue:[[NSString alloc] initWithFormat:@"%f", location.coordinate.latitude] forKey:@"latitude"];
        [data setValue:[[NSString alloc] initWithFormat:@"%f", location.coordinate.longitude] forKey:@"longitude"];
        [data setValue:[[NSString alloc] initWithFormat:@"%f", location.altitude] forKey:@"altitude"];
    } else {
        [data setValue:@"" forKey:@"latitude"];
        [data setValue:@"" forKey:@"longitude"];
        [data setValue:@"" forKey:@"altitude"];
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"application/json"]];
    [manager POST:[NSString stringWithFormat:@"http://ios.ioa.tw/api/v1/create_picture"]
       parameters:data constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        [formData appendPartWithFileData:UIImageJPEGRepresentation ([ImageUtility fixOrientation:self.pictureImageView.image], 0.1)
                                    name:@"name"
                                fileName:@"fg.jpg"
                                mimeType:@"image/jepg"];
       }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              [loadingAlert dismissWithClickedButtonIndex:-1 animated:YES];

              if ([[responseObject objectForKey:@"status"] boolValue]) {
                  [self cleanData];
                  [[NSNotificationCenter defaultCenter] postNotificationName:@"goToTabIndex0" object:nil];
              } else {
                  [[[UIAlertView alloc] initWithTitle:@"提示，照片上傳失敗！"
                                              message:[responseObject objectForKey:@"message"]
                                     cancelButtonItem:[RIButtonItem itemWithLabel:@"確定"]
                                     otherButtonItems:nil, nil] show];
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [loadingAlert dismissWithClickedButtonIndex:-1 animated:YES];
              
              [[[UIAlertView alloc] initWithTitle:@"提示"
                                          message:@"連線失敗，請確認網路連線狀況後再試一次..."
                                 cancelButtonItem:[RIButtonItem itemWithLabel:@"確定" ]
                                 otherButtonItems:nil, nil] show];
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
    if ([self.descriptionTextView.text length] <= 0) {
        UIAlertView *AlertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"請輸入照片說明喔！"
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

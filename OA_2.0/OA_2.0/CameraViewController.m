//
//  CameraViewController.m
//  OA_2.0
//
//  Created by OA Wu on 2015/6/22.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController () {
    UIImagePickerController *imagePickerController;
    BOOL hasChoice;
}

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.scrollView.contentSize =CGSizeMake(320, 700);
//    NSLog(@"%f", self.frame.origin.y);
//    [self.wantReply setFrame:CGRectMake(self.wantReply.frame.origin.x, self.loginUserLogo.frame.origin.y + 10, self.wantReply.frame.size.width, self.wantReply.frame.size.height)];
    //    [self.scrollView setContentSize:CGSizeMake(0, 0)];
//    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
//    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
//    self.scrollView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height + 10);
//    self.scrollView.backgroundColor = [UIColor redColor];
//    self.scrollView.scrollEnabled = YES;
//    scrollView.pagingEnabled = YES;
//    self.scrollView.showsVerticalScrollIndicator = YES;
//    self.scrollView.showsHorizontalScrollIndicator = YES;
//    [self.view addSubview:self.scrollView];
    
//    float width = 50;
//    float height = 50;
//    float xPos = 10;
//    float yPos = 10;
//    
//    UIView* view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 200)];
//    view1.backgroundColor = [UIColor blueColor];
//    view1.center = self.scrollView.center;
//    [self.scrollView addSubview:view1];

//
//    UIView* view2 = [[UIView alloc] initWithFrame:CGRectMake(xPos, self.view.bounds.size.height + yPos, width, height)];
//    view2.backgroundColor = [UIColor greenColor];
//    [self.scrollView addSubview:view2];
//    UIImage *imageView = [UIImage alloc] initWithFrame:CGRectMake(xPos, yPos, width, height)];
//    imageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 200);
//    imageView.center = self.scrollView.center;
//    imageView.backgroundColor = [UIColor blueColor];
//    [self.scrollView addSubview:imageView];
//    self.boxView.frame = CGRectMake(0, 0, 10, 10);
//    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    
//    [self.boxView.layer setBorderColor:[UIColor colorWithRed:208.0/255.0 green:209.0/255.0 blue:213.0/255.0 alpha:1].CGColor];
//    [self.boxView.layer setBorderWidth:1.0f];
//    [self.boxView.layer setCornerRadius:2];
//    [self.boxView.layer setMasksToBounds:YES];
//    [self.boxView setClipsToBounds:YES];
    
//    NSLog(@"%f", CGRectGetWidth (self.boxView.bounds));
////    
//    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth (self.boxView.bounds), CGRectGetHeight (self.boxView.bounds))];
//    backgroundView.backgroundColor = [UIColor blackColor];
////
//    [backgroundView.layer setBorderColor:[UIColor colorWithRed:208.0/255.0 green:209.0/255.0 blue:213.0/255.0 alpha:1].CGColor];
//    [backgroundView.layer setBorderWidth:1.0f];
////    [backgroundView.layer setCornerRadius:2];
//////    [backgroundView.layer setMasksToBounds:YES];
////
//    [self.boxView addSubview:backgroundView];

//    backgroundView.clipsToBounds = NO;
    
    
    [self.borderView.layer setBorderColor:[UIColor colorWithRed:208.0/255.0 green:209.0/255.0 blue:213.0/255.0 alpha:1].CGColor];
    [self.borderView.layer setBorderWidth:1.0f];
    [self.borderView.layer setCornerRadius:2];


    [self.defaultImageView.layer setBorderColor:[UIColor grayColor].CGColor];
    [self.defaultImageView.layer setBorderWidth:1.0f];
    [self.defaultImageView.layer setCornerRadius:2];
    [self.defaultImageView.layer setMasksToBounds:YES];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchDefaultImage)];
    singleTap.numberOfTapsRequired = 1;
    [self.defaultImageView setUserInteractionEnabled:YES];
    [self.defaultImageView addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self action:@selector(touchesBegan)];
    tapGesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGesture];
    
    [self.titleTextField setDelegate:self];
}
//-(void)viewWillAppear:(BOOL)animated {
//    [self initAndCleanView];
//}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.titleTextField resignFirstResponder];
    return YES;
}

-(void) initAndCleanView {
    hasChoice = NO;
    self.defaultImageView.image = [UIImage imageNamed:@"defaultImageView.png"];
}

-(void)touchDefaultImage {
    
    [self touchesBegan];
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"請選擇方式"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:@"拍照"
                                  otherButtonTitles:@"選取照片", nil];

    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)touchesBegan {
    [self textFieldShouldReturn:self.titleTextField];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
- (IBAction)openCameraButtonAction:(id)sender {
    [self showCamera];
}
- (IBAction)openAlbumButtonAction:(id)sender {
    [self showPhotoLibrary];
}
- (IBAction)submitButtonAction:(id)sender {
    
    UIAlertView *loadinfAlert = [[UIAlertView alloc] initWithTitle:@"Loading..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [loadinfAlert show];

    if (!hasChoice) {
        [loadinfAlert dismissWithClickedButtonIndex:-1 animated:YES];
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"請挑選或使用相機拍攝一張照片！" delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
        [myAlertView show];
        return;
    }
    
    if ([self.titleTextField.text length] <= 0) {
        [loadinfAlert dismissWithClickedButtonIndex:-1 animated:YES];
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"請輸入此照片的簡潔說明！" delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
        [myAlertView show];
        return;
    }
    
    
    NSData *imageData = UIImageJPEGRepresentation ([self fixOrientation:self.defaultImageView.image ], 0.1);

    MyHttp *http = [MyHttp new];
    
    NSMutableDictionary *vars = [NSMutableDictionary new];
    [vars setObject:self.titleTextField.text forKey:@"title"];
    [vars setObject:imageData forKey:@"name"];
    
    [http postMulti:@"http://ios.ioa.tw/api/add_picture" vars:vars completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [loadinfAlert dismissWithClickedButtonIndex:-1 animated:YES];
            UIAlertView *messageAlert = [[UIAlertView alloc] initWithTitle:@"提示" message:nil delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
    
            
            if ([[result objectForKey:@"status"] boolValue]) {
                [messageAlert setMessage:@"照片上傳成功！"];
            } else {
                [messageAlert setMessage:@"照片上傳失敗！"];
            }
            [messageAlert show];
        });
    }];
}
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
//}
//- (void)a
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([alertView.title isEqualToString:@"提示"] && [alertView.message isEqualToString:@"照片上傳成功！"]) {
        NSLog(@"dasdasdsa");
    }
    
}
- (UIImage *)fixOrientation: (UIImage *) myImage {
    
    // No-op if the orientation is already correct
    if (myImage.imageOrientation == UIImageOrientationUp) return myImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (myImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, myImage.size.width, myImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, myImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, myImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (myImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, myImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, myImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, myImage.size.width, myImage.size.height,
                                             CGImageGetBitsPerComponent(myImage.CGImage), 0,
                                             CGImageGetColorSpace(myImage.CGImage),
                                             CGImageGetBitmapInfo(myImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (myImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,myImage.size.height,myImage.size.width), myImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,myImage.size.width,myImage.size.height), myImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
- (void) showCamera {
    imagePickerController = [UIImagePickerController new];
    //來源:相機
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    //使用後鏡頭
    imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    //相片模式
    imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
    //閃光燈自動
    imagePickerController.cameraFlashMode = UIImagePickerControllerCameraFlashModeAuto;
    
    imagePickerController.delegate = self;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)showPhotoLibrary {
    //設定圖片來源為圖庫
    imagePickerController = [UIImagePickerController new];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [imagePickerController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    //========================
    
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    self.defaultImageView.image = image;
    hasChoice = YES;
    
    if ([self.titleTextField.text length] <= 0) {
        [self.titleTextField becomeFirstResponder];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
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

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
    self.scrollView.backgroundColor = [UIColor redColor];
//    self.scrollView.scrollEnabled = YES;
//    scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = YES;
    self.scrollView.showsHorizontalScrollIndicator = YES;
//    [self.view addSubview:self.scrollView];
    
//    float width = 50;
//    float height = 50;
//    float xPos = 10;
//    float yPos = 10;
//    
    UIView* view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 200)];
    view1.backgroundColor = [UIColor blueColor];
    view1.center = self.scrollView.center;
    [self.scrollView addSubview:view1];

//
//    UIView* view2 = [[UIView alloc] initWithFrame:CGRectMake(xPos, self.view.bounds.size.height + yPos, width, height)];
//    view2.backgroundColor = [UIColor greenColor];
//    [self.scrollView addSubview:view2];
//    UIImage *imageView = [UIImage alloc] initWithFrame:CGRectMake(xPos, yPos, width, height)];
//    imageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 200);
//    imageView.center = self.scrollView.center;
//    imageView.backgroundColor = [UIColor blueColor];
//    [self.scrollView addSubview:imageView];
    
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    
//    NSLog(@"%@", MyUITabBarController)
//    UIActionSheet *actionSheet = [[UIActionSheet alloc]
//                                  initWithTitle:@"請選擇方式"
//                                  delegate:self
//                                  cancelButtonTitle:@"取消"
//                                  destructiveButtonTitle:@"拍照"
//                                  otherButtonTitles:@"選取照片", nil];
//
//    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}
//判斷ActionSheet按鈕事件
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    //NSLog(@"%i",buttonIndex);
//    
//    //將按鈕的Title當作判斷的依據
//    //NSString *title = [actionSheet buttonTitleAtIndex:buttonIndex];
//    
//    switch (buttonIndex) {
//        case 0:
//            //拍照
//            [self showCamera];
//            break;
//        case 1:
//            //選取照片
////            [self showPhotoLibrary];
//            break;
//        default:
//            //取消->退回首頁
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"goToTabIndex0" object:nil];
//            break;
//    }
//}

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
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    //========================
    //    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    //    self.image.image = image;
    //    [self dismissViewControllerAnimated:YES completion:nil];
    //========================
    
//    UIImage *image = [self fixOrientation:[info valueForKey:UIImagePickerControllerOriginalImage]];
//    NSData *data = UIImageJPEGRepresentation(image, 0.5);
//    NSString *fullPath = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/data/xxx.jpg"];
    //    [data writeToFile:fullPath atomically:NO];
    
//    [myAlertView dismissWithClickedButtonIndex:-1 animated:YES];
    
//    
//    UploadViewController *upLoadImage = [UploadViewController new];
////    upLoadImage.selectImage = image;
//    
////    [USER_DEFAULTS setBool:YES forKey:@"isChoiceMenu"];
//    
//    
//    [self dismissViewControllerAnimated:YES completion:nil];
//    
//    //推出圖片上傳頁(因為有"選擇分類"&"收藏雜誌",會用到pushVC,所以需用UINavigationController包裝)
//    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:upLoadImage];
//    [self presentViewController:nvc animated:YES completion:nil];
//    
    
    
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

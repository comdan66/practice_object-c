//
//  CameraViewController.h
//  OA_2.0
//
//  Created by OA Wu on 2015/6/22.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyHttp.h"

@interface CameraViewController : UIViewController<UITextFieldDelegate, UIActionSheetDelegate, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *boxView;
@property (weak, nonatomic) IBOutlet UIView *borderView;
@property (weak, nonatomic) IBOutlet UIImageView *defaultImageView;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UIButton *openCameraButton;
@property (weak, nonatomic) IBOutlet UIButton *openAlbumButton;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;


//@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

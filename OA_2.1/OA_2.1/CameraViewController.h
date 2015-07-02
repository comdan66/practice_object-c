//
//  CameraViewController.h
//  OA_2.1
//
//  Created by OA Wu on 2015/6/27.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"
#import "AFHTTPRequestOperationManager.h"
#import "ImageUtility.h"
#import "UIAlertView+Blocks.h"
#import "AppDelegate.h"


@interface CameraViewController : UIViewController <UITextViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *borderView;
@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end

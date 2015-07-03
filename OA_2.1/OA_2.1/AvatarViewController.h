//
//  AvatarViewController.h
//  OA_2.1
//
//  Created by OA Wu on 2015/7/2.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingTableViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIAlertView+Blocks.h"
#import "AsyncImageView.h"
#import "Config.h"

@interface AvatarViewController : UIViewController
@property  AsyncImageView *avatarImageView;
@property UIButton *cameraButton, *albumButton;
@property UIView *avatarView;

@end

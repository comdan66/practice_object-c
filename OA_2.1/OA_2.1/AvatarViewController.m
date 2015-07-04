//
//  AvatarViewController.m
//  OA_2.1
//
//  Created by OA Wu on 2015/7/2.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "AvatarViewController.h"

@interface AvatarViewController ()

@end

@implementation AvatarViewController


//- (void)backPreviousVC {
//    SettingTableViewController *previousVC = (SettingTableViewController *)[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
//    [previousVC test];
////    [self.navigationController popViewControllerAnimated:YES];
//            [self.navigationController popToRootViewControllerAnimated:YES];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIAlertView *loadAlert = [[UIAlertView alloc] initWithTitle:@"Loading.."
//                                                        message:nil
//                                               cancelButtonItem:nil
//                                               otherButtonItems:nil, nil];
//    [loadAlert show];
//    
//    [self loadData:loadAlert];
    [self initUI];
    
//    UIBarButtonItem *barButtonItem = [UIBarButtonItem new];
//    [barButtonItem setTitle:@"dasd"];
//    [barButtonItem setStyle:UIBarButtonItemStylePlain];
//    [barButtonItem setAction:@selector(backPreviousVC)];
//    [barButtonItem setTarget:self];
//
//    self.navigationItem.leftBarButtonItem = barButtonItem;
    
}
- (void)initNav {
    [self.navigationItem setTitle:@"頭像設定"];
    
    UIBarButtonItem *saveBarButtonItem = [UIBarButtonItem new];
    [saveBarButtonItem setTitle:@"儲存"];
    [saveBarButtonItem setStyle:UIBarButtonItemStylePlain];
//    [barButtonItem setAction:@selector(backPreviousVC)];
    [saveBarButtonItem setTarget:self];
    [self.navigationItem setRightBarButtonItem: saveBarButtonItem];
}
- (void)initAvatarView {
    CGFloat width = 200.0;
    
    self.avatarView = [UIView new];
    
    [self.avatarView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.avatarView.layer setCornerRadius:width / 2];
    [self.avatarView.layer setShadowColor:[UIColor colorWithRed:0.15 green:0.16 blue:0.13 alpha:1].CGColor];
    [self.avatarView.layer setShadowOffset:CGSizeMake(0.5f, 0.5f)];
    [self.avatarView.layer setShadowRadius:3.0f];
    [self.avatarView.layer setShadowOpacity:0.5f];
    
    [self.view addSubview:self.avatarView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.topLayoutGuide
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1
                                                           constant:30.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:width]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:width]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];

}
- (void)initAvatar {
    CGFloat width = 200.0;
    
    self.avatarImageView = [AsyncImageView new];
    
    [self.avatarImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:self.avatarImageView];
    [self.avatarImageView setContentMode:UIViewContentModeScaleToFill];
    [self.avatarImageView.layer setBorderColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor];
    [self.avatarImageView.layer setBorderWidth:10.0f / [UIScreen mainScreen].scale];
    [self.avatarImageView.layer setCornerRadius:width / 2];
    [self.avatarImageView setClipsToBounds:YES];
    
    if ([[USER_DEFAULTS objectForKey:@"user"] objectForKey:@"color"] != nil) {
        id color = [[USER_DEFAULTS objectForKey:@"user"] objectForKey:@"color"];
        [self.avatarImageView setBackgroundColor:[UIColor colorWithRed:[[color objectForKey:@"red"] doubleValue] / 255.0f
                                                                 green:[[color objectForKey:@"green"] doubleValue] / 255.0f
                                                                  blue:[[color objectForKey:@"blue"] doubleValue] / 255.0f alpha:1.0f]];
    } else {
        [self.avatarImageView setBackgroundColor:[UIColor colorWithRed:236.0/255.0 green:140.0/255.0 blue:113.0/255.0 alpha:.3]];
    }
    
    [self.avatarImageView setImageURL:[NSURL URLWithString:[[[USER_DEFAULTS objectForKey:@"user"] objectForKey:@"avatar"] objectForKey:@"ori"]]];
    [self.avatarImageView setContentMode:UIViewContentModeScaleAspectFill];
    
    [self.avatarView addSubview:self.avatarImageView];
    
    [self.avatarView addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarImageView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.avatarView
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                                 constant:0]];
    
    [self.avatarView addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarImageView
                                                                attribute:NSLayoutAttributeLeading
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.avatarView
                                                                attribute:NSLayoutAttributeLeading
                                                               multiplier:1
                                                                 constant:0]];
    
    [self.avatarView addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarImageView
                                                                attribute:NSLayoutAttributeTrailing
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.avatarView
                                                                attribute:NSLayoutAttributeTrailing
                                                               multiplier:1
                                                                 constant:0]];
    
    [self.avatarView addConstraint:[NSLayoutConstraint constraintWithItem:self.avatarImageView
                                                                attribute:NSLayoutAttributeBottom
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.avatarView
                                                                attribute:NSLayoutAttributeBottom
                                                               multiplier:1
                                                                 constant:0]];
}
- (void)initCameraButton {
    self.cameraButton = [UIButton new];
    [self.cameraButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.cameraButton setTitle:@"開啟相機" forState:UIControlStateNormal];
    [self.cameraButton setTitleColor:[UIColor colorWithRed:0.76 green:0.76 blue:0.76 alpha:1] forState:UIControlStateHighlighted];
    [self.cameraButton setTitleColor:[UIColor colorWithRed:0.15 green:0.16 blue:0.13 alpha:.7] forState:UIControlStateNormal];
    [self.cameraButton.layer setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:.3].CGColor];
    [self.cameraButton.layer setBorderColor:[UIColor colorWithRed:0.79 green:0.74 blue:0.72 alpha:1.0].CGColor];
    [self.cameraButton.layer setBorderWidth:1.0f / [UIScreen mainScreen].scale];
    [self.cameraButton.layer setCornerRadius:3];
    [self.cameraButton setClipsToBounds:YES];
    
    [self.view addSubview:self.cameraButton];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.cameraButton
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.avatarImageView
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1
                                                           constant:40.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.cameraButton
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:200]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.cameraButton
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:40]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.cameraButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.avatarImageView
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];
}
- (void)initAlbumButton {
    self.albumButton = [UIButton new];
    [self.albumButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.albumButton setTitle:@"開啟相機" forState:UIControlStateNormal];
    [self.albumButton setTitleColor:[UIColor colorWithRed:0.76 green:0.76 blue:0.76 alpha:1] forState:UIControlStateHighlighted];
    [self.albumButton setTitleColor:[UIColor colorWithRed:0.15 green:0.16 blue:0.13 alpha:.7] forState:UIControlStateNormal];
    [self.albumButton.layer setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:.3].CGColor];
    [self.albumButton.layer setBorderColor:[UIColor colorWithRed:0.79 green:0.74 blue:0.72 alpha:1.0].CGColor];
    [self.albumButton.layer setBorderWidth:1.0f / [UIScreen mainScreen].scale];
    [self.albumButton.layer setCornerRadius:3];
    [self.albumButton setClipsToBounds:YES];
    
    [self.view addSubview:self.albumButton];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.albumButton
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.cameraButton
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1
                                                           constant:20.0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.albumButton
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:200]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.albumButton
                                                          attribute:NSLayoutAttributeHeight
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1.0
                                                           constant:40]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.albumButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.cameraButton
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.0
                                                           constant:0.0]];}
- (void)initUI {
    
    [self.view.layer setBackgroundColor:[UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1].CGColor];
    
    [self initNav];
    [self initAvatarView];
    [self initAvatar];
    [self initCameraButton];
    [self initAlbumButton];
}

- (void)loadData:(UIAlertView *) alert{
    
//
//    NSMutableDictionary *data = [[NSMutableDictionary alloc]init];
//    [data setValue:nextId forKey:@"next_id"];
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"application/json"]];
//    [manager GET:[NSString stringWithFormat:@"http://ios.ioa.tw/api/v1/next_pictures"]
//      parameters:data
//         success:^(AFHTTPRequestOperation *operation, id responseObject) {
//             if ([[responseObject objectForKey:@"status"] boolValue]) {
//                 for (NSMutableDictionary *picture in [responseObject objectForKey:@"pictures"]) {
//                     [pictures addObject: picture];
//                 }
//                 nextId = [[NSString alloc] initWithFormat:@"%@", [responseObject objectForKey:@"next_id"]];
//                 
//                 if ([nextId doubleValue] >= 0)
//                     isLoading = NO;
//             }
//             
//             if (alert != nil)
//                 [alert dismissWithClickedButtonIndex:-1 animated:YES];
//             
//             [self.tableView reloadData];
//             
//         }
//         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//             if (alert != nil)
//                 [alert dismissWithClickedButtonIndex:-1 animated:YES];
//             
//             [[[UIAlertView alloc] initWithTitle:@"提示"
//                                         message:@"連線失敗，請確認網路連線狀況後再試一次..."
//                                cancelButtonItem:[RIButtonItem itemWithLabel:@"確定" ]
//                                otherButtonItems:nil, nil] show];
//         }
//     ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

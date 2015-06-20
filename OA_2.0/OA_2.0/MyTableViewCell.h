//
//  MyTableViewCell.h
//  OA_2.0
//
//  Created by OA Wu on 2015/6/19.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface MyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *borderView;
@property (weak, nonatomic) IBOutlet AsyncImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet AsyncImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIView *avatarView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

- (IBAction)likeButtonPress:(id)sender;
- (IBAction)commentButtonPress:(id)sender;

@end

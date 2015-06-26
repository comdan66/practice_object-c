//
//  IndexTableViewCell.h
//  OA_2.1
//
//  Created by OA Wu on 2015/6/25.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface IndexTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *borderView;
@property (weak, nonatomic) IBOutlet AsyncImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet AsyncImageView *avatarImageView;

//@property (weak, nonatomic) IBOutlet AsyncImageView *pictureImageView;
//@property (weak, nonatomic) IBOutlet UIView *avatarBorderView;
//@property (weak, nonatomic) IBOutlet AsyncImageView *avatarImageView;
//@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//@property (weak, nonatomic) IBOutlet UILabel *horizontalRuleLabel;
//@property (weak, nonatomic) IBOutlet UILabel *verticalDividerLabel;
//@property (weak, nonatomic) IBOutlet UIButton *likeButton;
//@property (weak, nonatomic) IBOutlet UIButton *commentButton;
+ (UIFont *) titleFont;

- (void)initUI:(id)picture w:(float)w;
@end
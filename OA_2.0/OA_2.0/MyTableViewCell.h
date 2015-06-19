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

@end

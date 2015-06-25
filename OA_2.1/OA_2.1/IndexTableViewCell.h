//
//  IndexTableViewCell.h
//  OA_2.1
//
//  Created by OA Wu on 2015/6/25.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IndexTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *borderView;

- (void)initUI;
@end

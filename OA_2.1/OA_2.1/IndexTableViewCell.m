//
//  IndexTableViewCell.m
//  OA_2.1
//
//  Created by OA Wu on 2015/6/25.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "IndexTableViewCell.h"

@implementation IndexTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)initUI {
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
//    cell.textLabel.text = @"asd";
}
@end

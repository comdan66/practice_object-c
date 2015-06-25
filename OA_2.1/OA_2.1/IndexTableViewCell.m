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
    
    [self.contentView.layer setBackgroundColor:[UIColor colorWithRed:0.92 green:0.92 blue:0.93 alpha:1].CGColor];
    
    [self.borderView.layer setBorderColor:[UIColor colorWithRed:0.84 green:0.82 blue:0.84 alpha:1].CGColor];
    [self.borderView.layer setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1].CGColor];
    [self.borderView.layer setBorderWidth:1.0f];
    [self.borderView.layer setCornerRadius:5];
    [self.borderView setClipsToBounds:YES];
    
//    cell.textLabel.text = @"asd";
}
@end

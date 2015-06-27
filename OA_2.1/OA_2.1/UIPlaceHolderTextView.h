//
//  UIPlaceHolderTextView.h
//  OA_2.1
//
//  Created by OA Wu on 2015/6/27.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPlaceHolderTextView : UITextView

@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end

//
//  MarkerView.m
//  map1
//
//  Created by OA Wu on 2015/7/1.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "MarkerView.h"

@implementation MarkerView
@synthesize nibType;

+ (MarkerView *)initSingle {
    MarkerView *markView = [[[NSBundle mainBundle] loadNibNamed:@"SingleMarkerView" owner:nil options:nil] lastObject];
    
    if ([markView isKindOfClass:[MarkerView class]]) {
        markView.nibType = @"Single";
        return markView;
    } else
        return nil;
}
+ (MarkerView *)initMulti {
    MarkerView *markView = [[[NSBundle mainBundle] loadNibNamed:@"MultiMarkerView" owner:nil options:nil] lastObject];
    
    if ([markView isKindOfClass:[MarkerView class]]) {
        markView.nibType = @"Multi";
        return markView;
    } else
        return nil;
}

- (void)initUI:(NSURL *) url {

    self.frame = CGRectMake(0, 0, 50, 50);
    
    if ([nibType isEqualToString:@"Multi"]) {
    
    } else {
        CGFloat radius = 2.0f;
        
        [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:self.mainImageView];
        [self.mainImageView setImageURL:url];
        
        [self.mainImageView.layer setBorderColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1].CGColor];
        [self.mainImageView.layer setBorderWidth:8.0f / [UIScreen mainScreen].scale];
        [self.mainImageView setClipsToBounds:YES];
        [self.mainImageView.layer setCornerRadius:radius];
        [self.mainImageView setContentMode:UIViewContentModeScaleAspectFill];
        
        [self.bgView.layer setShadowColor:[UIColor colorWithRed:0.15 green:0.16 blue:0.13 alpha:1].CGColor];
        [self.bgView.layer setShadowOffset:CGSizeMake(2.4f, 2.0f)];
        [self.bgView.layer setShadowRadius:5.0f];
        [self.bgView.layer setShadowOpacity:0.5f];
        [self.bgView.layer setCornerRadius:radius];
    }
}
@end

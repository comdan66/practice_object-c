//
//  MarkerView.m
//  map1
//
//  Created by OA Wu on 2015/7/1.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "MarkerView.h"

@implementation MarkerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (id)customView
{
    MarkerView *se = [[[NSBundle mainBundle] loadNibNamed:@"MarkerView" owner:nil options:nil] lastObject];
    
    // make sure customView is not nil or the wrong class!
    if ([se isKindOfClass:[MarkerView class]])
        return se;
    else
        return nil;
}
- (void)initUI:(NSURL *) url {
    NSLog(@"ddd");
    
        [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:self.mainImageView];
        [self.mainImageView setImageURL:url];
    
    //    [imageView.layer setCornerRadius:30];
        [self.mainImageView.layer setBorderColor:[UIColor redColor].CGColor];
        [self.mainImageView.layer setBorderWidth:10.0f / [UIScreen mainScreen].scale];
    //    [imageView setClipsToBounds:YES];
        [self.mainImageView setContentMode:UIViewContentModeScaleAspectFill];
    
        [self.mainImageView.layer setShadowColor:[UIColor colorWithRed:0.15 green:0.16 blue:0.13 alpha:1].CGColor];
        [self.mainImageView.layer setShadowOffset:CGSizeMake(2.4f, 2.0f)];
        [self.mainImageView.layer setShadowRadius:5.0f];
        [self.mainImageView.layer setShadowOpacity:0.5f];
}
@end

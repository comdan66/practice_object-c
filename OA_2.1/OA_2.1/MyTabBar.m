//
//  MyTabBar.m
//  OA_2.1
//
//  Created by OA Wu on 2015/6/25.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "MyTabBar.h"

@implementation MyTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIImage *)addBorderToImage:(UIImage *)image {
    CGImageRef bgimage = [image CGImage];
    float width = CGImageGetWidth(bgimage);
    float height = CGImageGetHeight(bgimage);
    
    // Create a temporary texture data buffer
    void *data = malloc(width * height * 4);
    
    // Draw image to buffer
    CGContextRef ctx = CGBitmapContextCreate(data,
                                             width,
                                             height,
                                             8,
                                             width * 4,
                                             CGImageGetColorSpace(image.CGImage),
                                             (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(ctx, CGRectMake(0, 0, (CGFloat)width, (CGFloat)height), bgimage);
    
    //Set the stroke (pen) color
    CGContextSetStrokeColorWithColor(ctx, [UIColor greenColor].CGColor);
    
    //Set the width of the pen mark
//    CGFloat borderWidth = (float)width*0.05;
//    CGContextSetLineWidth(ctx, borderWidth);
//    
//    //Start at 0,0 and draw a square
//    CGContextMoveToPoint(ctx, 0.0, 0.0);
//    CGContextAddLineToPoint(ctx, 0.0, height);
//    CGContextAddLineToPoint(ctx, width, height);
//    CGContextAddLineToPoint(ctx, width, 0.0);
//    CGContextAddLineToPoint(ctx, 0.0, 0.0);
//    
////    Draw it
//    CGContextStrokePath(ctx);
    
    // write it to a new image
    CGImageRef cgimage = CGBitmapContextCreateImage(ctx);
    UIImage *newImage = [UIImage imageWithCGImage:cgimage];
    CFRelease(cgimage);
    CGContextRelease(ctx);
    
    // auto-released
    return newImage;
}
-(CGSize)sizeThatFits:(CGSize)size {
    CGSize sizeThatFits = [super sizeThatFits:size];
    sizeThatFits.height = 45;
    return sizeThatFits;
}
- (void)initUI {
    [self setBarTintColor:[UIColor colorWithRed:254.0/255.0 green:210.0/255.0 blue:51.0/255.0 alpha:1.0]];
    [self setAlpha:0.9f];
    
    [self.layer setShadowColor:[UIColor colorWithRed:39.0/255.0 green:40.0/255.0 blue:34.0/255.0 alpha:1].CGColor];
    [self.layer setShadowOffset:CGSizeMake(0.0f, 0.0f)];
    [self.layer setShadowRadius:3.0f];
    [self.layer setShadowOpacity:0.3f];
    
    [self initItem];
    
}
- (void)initItem {    
    for (int i = 0; i < [self.items count]; i++) {
        UITabBarItem * tabItem = [self.items objectAtIndex:i];
        [tabItem setImageInsets:UIEdgeInsetsMake(6, 0, -6, 0)];
        [tabItem setImage:[[UIImage imageNamed:[NSString stringWithFormat: @"TabBarItem_%02i.png", i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [tabItem setSelectedImage:[[UIImage imageNamed:[NSString stringWithFormat: @"TabBarItem_%02i_on.png", i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
}
@end

//
//  TestView.m
//  Arc
//
//  Created by OA Wu on 2015/7/8.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "TestView.h"

@implementation TestView

static TestView *myInstance = nil;

+ (TestView *)shared {
    if (myInstance == nil) {
        myInstance = [[TestView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
        myInstance.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return myInstance;
}
+ (void)dismiss {
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    [[self shared] selfHide];
}
+ (void)show {
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [[self shared] selfShow];
}
-(void)selfHide{
    NSLog(@"x");
    [[((AppDelegate *)([UIApplication sharedApplication].delegate)).window viewWithTag:123] removeFromSuperview];
//    [[((AppDelegate *)([UIApplication sharedApplication].delegate)).window viewWithTag:56790] removeFromSuperview];
}


- (void)touchAvatarImage {
    NSLog(@"v");
    [self selfHide];
}
-(void)selfShow{
    [self setBackgroundColor:[UIColor colorWithRed:0.47 green:0.8 blue:0.94 alpha:1]];
    [self.layer setBackgroundColor:[UIColor colorWithRed:0.47 green:0.8 blue:0.94 alpha:1].CGColor];
    [self setTag:123];
    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchAvatarImage)];
    singleTap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:singleTap];
    
//    [self setCenter:((AppDelegate *)([UIApplication sharedApplication].delegate)).window.center];
    
//    UIImageView *mView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    [mView setImage:[UIImage imageNamed:@"loading.png"]];
//    [mView setBackgroundColor:[UIColor colorWithRed:0.76 green:0.76 blue:0.76 alpha:1]];
//    mView.tag = 56789;
//    [mView setCenter:self.center];
//
//    UIImageView *mView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 100, 100)];
//    [mView2 setImage:[UIImage imageNamed:@"loading2.png"]];
//    [mView2 setBackgroundColor:[UIColor colorWithRed:0.86 green:0.76 blue:0.35 alpha:1]];
//    mView2.tag = 56790;
//    [mView2 setCenter:mView.center];
//    
//    if ([mView2.layer animationForKey:@"SpinAnimation"] == nil) {
//        CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//        animation.fromValue = [NSNumber numberWithFloat:0.0f];
//        animation.toValue = [NSNumber numberWithFloat: 2*M_PI];
//        animation.duration = 1.0f;
//        animation.repeatCount = INFINITY;
//        [mView2.layer addAnimation:animation forKey:@"SpinAnimation"];
//    }

    
    [((AppDelegate *)([UIApplication sharedApplication].delegate)).window addSubview:self];
//    [((AppDelegate *)([UIApplication sharedApplication].delegate)).window addSubview:mView];
//    [((AppDelegate *)([UIApplication sharedApplication].delegate)).window addSubview:mView2];
    
}
@end

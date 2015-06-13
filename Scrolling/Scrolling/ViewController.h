//
//  ViewController.h
//  Scrolling
//
//  Created by OA Wu on 2015/6/12.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIScrollViewAccessibilityDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *myScroll;
@property (weak, nonatomic) IBOutlet UIImageView *myImg;


@end


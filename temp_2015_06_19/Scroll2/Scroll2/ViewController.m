//
//  ViewController.m
//  Scroll2
//
//  Created by OA Wu on 2015/6/12.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *img1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.jpg" ]];
    UIImageView *img2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2.jpg" ]];
    UIImageView *img3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3.jpg" ]];
    
    img1.contentMode = UIViewContentModeScaleAspectFit;
    img2.contentMode = UIViewContentModeScaleAspectFit;
    img3.contentMode = UIViewContentModeScaleAspectFit;
    
    CGRect rect = self.myScroll.frame;
    img1.frame = rect;
    img2.frame = CGRectOffset(img1.frame, img1.frame.size.width, 0);
    img3.frame = CGRectOffset(img2.frame, img2.frame.size.width, 0);
    
    CGSize size = CGSizeMake(img1.frame.size.width + img2.frame.size.width + img3.frame.size.width, rect.origin.y);
    self.myScroll.contentSize = size;
    
    [self.myScroll addSubview:img1];
    [self.myScroll addSubview:img2];
    [self.myScroll addSubview:img3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

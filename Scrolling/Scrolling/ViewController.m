//
//  ViewController.m
//  Scrolling
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
    
    self.myScroll.delegate = self;
    self.myImg.contentMode = UIViewContentModeScaleAspectFill;
    self.myImg.image = [UIImage imageNamed:@"a.jpg"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [scrollView.subviews objectAtIndex:0];
}

@end

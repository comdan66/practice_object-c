//
//  ViewController.m
//  ImageAnimation
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
    
    NSMutableArray *imgs = [NSMutableArray new];
    [imgs addObject:[UIImage imageNamed:@"1.jpg"]];
    [imgs addObject:[UIImage imageNamed:@"2.jpg"]];
    [imgs addObject:[UIImage imageNamed:@"3.jpg"]];
    [imgs addObject:[UIImage imageNamed:@"4.jpg"]];
    [imgs addObject:[UIImage imageNamed:@"5.jpg"]];
    [imgs addObject:[UIImage imageNamed:@"6.jpg"]];
    self.myImg.contentMode = UIViewContentModeScaleAspectFill;
    self.myImg.animationImages = imgs;
    self.myImg.animationDuration = 10;
    self.myImg.animationRepeatCount = 2;
    
    [self.myImg startAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

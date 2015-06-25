//
//  IndexNavigationController.m
//  OA_2.1
//
//  Created by OA Wu on 2015/6/25.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "IndexNavigationController.h"

@interface IndexNavigationController ()

@end

@implementation IndexNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self.navigationBar setBarTintColor:[UIColor colorWithRed:254.0/255.0 green:210.0/255.0 blue:51.0/255.0 alpha:1.0]];
    
    [self.navigationBar setBarTintColor:[UIColor colorWithRed:254.0/255.0 green:210.0/255.0 blue:51.0/255.0 alpha:0.1]];
//    [self.navigationBar setAlpha:0.1f];
//    self.navigationBar.translucent = YES;
    
    [self.navigationBar.layer setShadowColor:[UIColor colorWithRed:39.0/255.0 green:40.0/255.0 blue:34.0/255.0 alpha:1].CGColor];
    [self.navigationBar.layer setShadowOffset:CGSizeMake(0.0f, 0.0f)];
    [self.navigationBar.layer setShadowRadius:3.0f];
    [self.navigationBar.layer setShadowOpacity:0.3f];
//    [self.navigationBar setHidden:YES];
    

//    [self automaticallyAdjustsScrollViewInsets:YES];
//    [self setNavigationBarHidden:YES animated:YES];
//    self.navigationBar.autoresizingMask ^= UIViewAutoresizingFlexibleHeight;
//    self.edgesForExtendedLayout = UIRectEdgeTop;
    
//    [self.navigationBar setBackgroundImage:[UIImage new]
//                                                  forBarMetrics:UIBarMetricsDefault];
//    self.navigationBar.shadowImage = [UIImage new];
//    self.navigationBar.translucent = YES;
//    self.view.backgroundColor = [UIColor clearColor];
//    self.navigationBar.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

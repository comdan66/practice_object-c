//
//  MyUITabBarController.m
//  OA_1.5
//
//  Created by OA Wu on 2015/6/16.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "MyUITabBarController.h"

@interface MyUITabBarController ()

@end

@implementation MyUITabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    for (int i = 0; i < [self.tabBar.items count]; i++) {
        UIImage *image = [[UIImage imageNamed:[NSString stringWithFormat: @"%02i.png", i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UITabBarItem * tabItem = [self.tabBar.items objectAtIndex:i];
        if (tabItem != nil) {
            tabItem.image = image;
        }
    }
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

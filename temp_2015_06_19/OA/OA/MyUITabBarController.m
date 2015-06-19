//
//  MyUITabBarController.m
//  OA
//
//  Created by OA Wu on 2015/6/13.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "MyUITabBarController.h"

@interface MyUITabBarController ()

@end

@implementation MyUITabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UITabBarItem *tabBarItem0 = [self.tabBar.items objectAtIndex:0];
//
////    [tabBarItem0 setFinishedSelectedImage:[UIImage imageNamed:@"01.jpg"] withFinishedUnselectedImage:[UIImage imageNamed:@"01.jpg"]];
//    [tabBarItem0 initWithTitle:@"首頁" image:[UIImage imageNamed:@"01.jpg"] selectedImage:[UIImage imageNamed:@"01.jpg"]];
//    tabBarItem0 = [[UITabBarItem alloc] initWithTitle:nil image:[[UIImage imageNamed:@"01.jpg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] tag:3];
//    [navMaps setTabBarItem:maps];
    
    for (int i = 0; i < 5; i++) {
        UIImage *image = [[UIImage imageNamed:[NSString stringWithFormat: @"%02i.png", i + 1]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        UITabBarItem * tabItem = [self.tabBar.items objectAtIndex:i];
        tabItem.image = image;
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

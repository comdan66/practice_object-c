//
//  AvatarViewController.m
//  OA_2.1
//
//  Created by OA Wu on 2015/7/2.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "AvatarViewController.h"

@interface AvatarViewController ()

@end

@implementation AvatarViewController


//- (void)backPreviousVC {
//    SettingTableViewController *previousVC = (SettingTableViewController *)[self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count - 2];
//    [previousVC test];
////    [self.navigationController popViewControllerAnimated:YES];
//            [self.navigationController popToRootViewControllerAnimated:YES];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"頭像設定"];
//    UIBarButtonItem *barButtonItem = [UIBarButtonItem new];
//    [barButtonItem setTitle:@"dasd"];
//    [barButtonItem setStyle:UIBarButtonItemStylePlain];
//    [barButtonItem setAction:@selector(backPreviousVC)];
//    [barButtonItem setTarget:self];
//
//    self.navigationItem.leftBarButtonItem = barButtonItem;
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

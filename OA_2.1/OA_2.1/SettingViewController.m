//
//  SettingViewController.m
//  OA_2.1
//
//  Created by OA Wu on 2015/6/28.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)test:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *mainViewController;
    
    mainViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
//    [self setRootViewController:mainViewController];
    
//    [release]
//   UIViewController *a = [[[UIApplication sharedApplication] delegate] window].rootViewController;
//    [a release];
    
    [[[[UIApplication sharedApplication] delegate] window] setRootViewController:mainViewController];
//    [self.window makeKeyAndVisible];
    
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

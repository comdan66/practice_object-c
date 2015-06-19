//
//  ViewController.m
//  OA_2.0
//
//  Created by OA Wu on 2015/6/19.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"logined"];
    [self showDetailViewController:vc sender:self];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginButton:(id)sender {
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"logined"];
    [self showDetailViewController:vc sender:self];
}

@end

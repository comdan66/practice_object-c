//
//  ViewController.m
//  OA_1.2
//
//  Created by OA Wu on 2015/6/16.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    NSMutableDictionary *vars = [NSMutableDictionary new];
//    [vars setObject:@"oa" forKey:@"account"];
//    [vars setObject:@"123" forKey:@"password"];
//    NSLog(@"%@", [vars objectForKey: @"account"]);
//    NSLog(@"%@", [vars objectForKey:[[vars allKeys] objectAtIndex:0]]);
    
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

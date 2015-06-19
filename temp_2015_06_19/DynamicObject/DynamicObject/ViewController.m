//
//  ViewController.m
//  DynamicObject
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
    UIButton *button = [UIButton new];
    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake (20, 20, 100, 40);
    
    [button setTitle:@"按我" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)buttonPress: (id) sender {
    NSLog(@"Hi!");
}

@end

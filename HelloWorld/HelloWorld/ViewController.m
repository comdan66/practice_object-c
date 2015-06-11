//
//  ViewController.m
//  HelloWorld
//
//  Created by OA Wu on 2015/6/11.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickbutton:(id)sender {
    self.textLabel.text = @"Hi, iOS 8";
}

@end

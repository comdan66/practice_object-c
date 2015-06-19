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
- (IBAction)click1Button:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"Click 1"]) {
        self.textLabel.text = @"Click 1 被按了！";
    } else {
        self.textLabel.text = @"Click 2 被按了！";
    }
}


@end

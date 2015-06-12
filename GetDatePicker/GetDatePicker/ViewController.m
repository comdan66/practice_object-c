//
//  ViewController.m
//  GetDatePicker
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dataPicker:(UIDatePicker *)sender {
    NSDateFormatter *formate = [NSDateFormatter new];
    [formate setDateFormat:@"yyy/M/d HH:mm:ss"];
    NSLog(@"現在時間為：%@", [formate stringFromDate:sender.date]);
}

@end

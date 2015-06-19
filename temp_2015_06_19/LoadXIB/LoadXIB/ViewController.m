//
//  ViewController.m
//  LoadXIB
//
//  Created by OA Wu on 2015/6/12.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "ViewController.h"
#import "XibViewController.h"

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
- (IBAction)button:(id)sender {
    XibViewController *xib = [[XibViewController alloc] initWithNibName:@"XibViewController" bundle:nil];

    [self presentViewController:xib animated: YES completion:nil];
}

@end

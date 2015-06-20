//
//  MyViewController.m
//  test
//
//  Created by OA Wu on 2015/6/20.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.leftBarButtonItem
//    self.navigationItem.hidesBackButton =YES;
//    UIButton * customButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [customButton setBackgroundColor:[UIColor colorWithRed:197.0/255.0 green:190.0/255.0 blue:157.0/255.0 alpha:1.0]];
//    [customButton setTitle:@"Do Something" forState:UIControlStateNormal];
//    customButton.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:11.0f];
//    [customButton.layer setCornerRadius:3.0f];
//    [customButton.layer setMasksToBounds:YES];
//    [customButton.layer setBorderWidth:1.0f];
//    [customButton.layer setBorderColor: [[UIColor grayColor] CGColor]];
//    customButton.frame=CGRectMake(0.0, 100.0, 50.0, 25.0);
////    [customButton addTarget:self action:@selector(customMethod:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem * customItem = [[UIBarButtonItem alloc] initWithCustomView:customButton];
//    customItem.tintColor=[UIColor blackColor];
//    self.navigationItem.leftBarButtonItem = customItem;
//    [self.navigationController popToRootViewControllerAnimated:YES];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ddd:(id)sender {
//    [self dismissModalViewControllerAnimated:YES];
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

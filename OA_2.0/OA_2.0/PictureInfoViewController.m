//
//  PictureInfoViewController.m
//  OA_2.0
//
//  Created by OA Wu on 2015/6/20.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "PictureInfoViewController.h"

@interface PictureInfoViewController ()

@end

@implementation PictureInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //    self.navigationItem.leftBarButtonItem
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
    
//    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [customButton setTitle:@"Do Something" forState:UIControlStateNormal];
//    UIBarButtonItem * customItem = [UIBarButtonItem new];
//    [customItem setTitle:@"<"];
////        customItem.tintColor=[UIColor blackColor];
//    self.navigationItem.leftBarButtonItem = customItem;
//    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] init];
    [self.navigationItem.leftBarButtonItem setTitle:@"❮ Back"];
    [self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStyleDone];
    [self.navigationItem.leftBarButtonItem setTarget:self];
    [self.navigationItem.leftBarButtonItem setAction:@selector(backButtonAction)];
    
    
//    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Loading..." message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
//    [myAlertView show];
}
-(void)backButtonAction  {
//    [self.backdelegate updateEvent:eventId title:eventTitle];
    [self.navigationController popViewControllerAnimated:YES];
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

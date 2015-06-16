//
//  EventViewController.h
//  OA_1.5
//
//  Created by OA Wu on 2015/6/16.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "ViewController.h"
#import "MyHttp.h"
#import "IndexTableViewController.h"
#import "BackDelegate.h"

@interface EventViewController : ViewController


@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) IBOutlet UIView *view;

@property (nonatomic, assign) id<BackDelegate> backdelegate;

- (void)prassEventId:(NSString *)id title:(NSString *)title;

@end

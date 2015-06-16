//
//  IndexTableViewController.h
//  OA_1.5
//
//  Created by OA Wu on 2015/6/16.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MyHttp.h"
#import "EventViewController.h"
#import "BackDelegate.h"

@interface IndexTableViewController : UITableViewController<BackDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end

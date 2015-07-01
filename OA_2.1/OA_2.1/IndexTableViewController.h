//
//  IndexTableViewController.h
//  OA_2.1
//
//  Created by OA Wu on 2015/6/25.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IndexTableViewCell2.h"
#import "AFHTTPRequestOperationManager.h"
#import "UIAlertView+Blocks.h"

@interface IndexTableViewController : UITableViewController <UIScrollViewDelegate>

- (void)loadNewPicture:(UIAlertView *)loadingAlert callbackBlock:(void (^)(UITableView *tableView))callbackBlock;

@end

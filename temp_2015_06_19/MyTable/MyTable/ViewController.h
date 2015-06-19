//
//  ViewController.h
//  MyTable
//
//  Created by OA Wu on 2015/6/15.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCell.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray *list;
}


@end


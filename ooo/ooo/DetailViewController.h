//
//  DetailViewController.h
//  ooo
//
//  Created by OA Wu on 2015/6/17.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end


//
//  ViewController.h
//  DecisionMaking
//
//  Created by OA Wu on 2015/6/10.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;

- (IBAction)pointsButtonPressed:(id)sender;
- (IBAction)weatherButtonPressed:(id)sender;
- (IBAction)gradeButtonPressed:(id)sender;


@end


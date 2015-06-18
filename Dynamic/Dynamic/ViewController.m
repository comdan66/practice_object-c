//
//  ViewController.m
//  Dynamic
//
//  Created by OA Wu on 2015/6/17.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) UIDynamicAnimator *animator;
@property (nonatomic) UIAttachmentBehavior *attrachBehavior;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    UIOffset hookPostion = UIOffsetMake(0, 0);
    self.attrachBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.box offsetFromCenter:hookPostion attachedToAnchor:self.item.frame.origin];
    [self.animator addBehavior:self.attrachBehavior];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)hand:(UIPanGestureRecognizer *)sender {
    [self.attrachBehavior setAnchorPoint:[sender locationInView:self.view]];
    self.item.center = self.attrachBehavior.anchorPoint;
}

@end

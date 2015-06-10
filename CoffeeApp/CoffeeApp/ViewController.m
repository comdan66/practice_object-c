//
//  ViewController.m
//  CoffeeApp
//
//  Created by OA Wu on 2015/6/10.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "ViewController.h"

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

- (IBAction)calculateButtonPressed:(id)sender {
    NSLog(@"Calculate Pressed");
    
    float water = [[self.waterTextField text] floatValue];
    float ratio = [[self.ratioTextField text] floatValue];
    
    NSLog(@"Water: %f, ratio: %f", water, ratio);
    
    float coffee = water / ratio;
    NSString *coffeeText = [NSString stringWithFormat:@"%f", coffee];
    
    self.coffeeTextField.text = coffeeText;
    
    
}
@end

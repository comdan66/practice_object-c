//
//  ViewController.m
//  DecisionMaking
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
- (IBAction)pointsButtonPressed:(id)sender {

    static int points = 95;
    
    if (points >= 100) {
        self.pointsLabel.text = @"You Won the game!";
    } else {
        self.pointsLabel.text = [NSString stringWithFormat:@"%d points remaining!", 100 - points];
    }
    
    points += 1;
}

- (IBAction)weatherButtonPressed:(id)sender {

    static BOOL cloudy = NO;
    
    if (cloudy) {
        self.weatherLabel.text = @"It's cloudy!";
    } else {
        self.weatherLabel.text = @"It's sunny!";
    }
    
    cloudy = !cloudy;
}

- (IBAction)gradeButtonPressed:(id)sender {

    int grade = 90;
    
    if (grade >= 70 && grade < 80) {
        self.gradeLabel.text = @"C";
    } else if (grade >= 80 && grade < 90) {
        self.gradeLabel.text = @"B";
    } else if (grade >= 90) {
        self.gradeLabel.text = @"A";
    } else {
        self.gradeLabel.text = @"D";
    }

}
@end

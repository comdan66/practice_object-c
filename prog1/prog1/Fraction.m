//
//  Fraction.m
//  prog1
//
//  Created by OA Wu on 2015/4/28.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "Fraction.h"

@implementation Fraction

@synthesize numerator, denominator;

-(void) print {
    NSLog(@" %i / %i", numerator, denominator);
}
-(double) covertToNum {
    if (denominator != 0)
        return (double) numerator / denominator;
    else
        return NAN;
}

@end
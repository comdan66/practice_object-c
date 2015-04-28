//
//  Fraction.m
//  prog1
//
//  Created by OA Wu on 2015/4/28.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "Fraction.h"

@implementation Fraction {
    int numerator;
    int denominator;
}

-(void) print {
    NSLog(@" %i / %i", numerator, denominator);
}
-(void) setNumerator: (int) n {
    numerator = n;
}
-(void) setDenominator: (int) d {
    denominator = d;
}
-(int) numerator {
    return numerator;
}
-(int) denominator {
    return denominator;
}
-(double) covertToNum {
    if (denominator != 0)
        return (double) numerator / denominator;
    else
        return NAN;
}

@end
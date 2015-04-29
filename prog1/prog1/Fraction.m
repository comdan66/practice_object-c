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
-(void) setTo: (int) n over: (int) d {
    numerator = n;
    denominator = d;
}
-(double) covertToNum {
    if (denominator != 0)
        return (double) numerator / denominator;
    else
        return NAN;
}
-(void) add: (Fraction *) f {
    numerator = numerator * f.denominator + denominator * f.numerator;
    denominator = denominator * f.denominator;
}
-(void) reduce {
    int u = numerator;
    int v = denominator;
    int temp;
    
    while (v != 0) {
        temp = u % v;
        u = v;
        v = temp;
    }
    
    numerator /= u;
    denominator /= u;
}
@end
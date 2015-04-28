//
//  main.m
//  prog1
//
//  Created by OA Wu on 2015/4/27.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fraction : NSObject

-(void) print;
-(void) setNumerator;
-(void) setDenominator;
-(int) numerator;
-(int) denominator;
-(double) covertToNum;

@end

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

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Fraction *frac1 = [[Fraction alloc] init];
        Fraction *frac2 = [[Fraction alloc] init];
        
        [frac1 setNumerator: 1];
        [frac1 setDenominator: 4];
        [frac1 print];
        NSLog(@" = %g", [frac1 covertToNum]);
        
        NSLog(@" = %g", [frac2 covertToNum]);
        
   }
    return 0;
}

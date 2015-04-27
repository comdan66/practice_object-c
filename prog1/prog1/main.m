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
-(void) setNumerator: (int) n;
-(void) setDenominator: (int) d;

-(int) numerator;
-(int) denominator;

@end

@implementation Fraction {
    int numerator;
    int denominator;
}

-(void) print {
    NSLog(@"%i / %i", numerator, denominator);
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

@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...

        Fraction *frac = [[Fraction alloc] init];

        [frac setNumerator: 1];
        [frac setDenominator: 3];
        
        NSLog(@"The frac numerator is: %i", [frac numerator]);
        NSLog(@"The frac denominator is: %i", [frac denominator]);
        [frac print];
    }
    return 0;
}

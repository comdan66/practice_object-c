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

@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...

        Fraction *frac1 = [[Fraction alloc] init];
        Fraction *frac2 = [[Fraction alloc] init];

        
        [frac1 setNumerator: 1];
        [frac1 setDenominator: 3];
        
        
        [frac2 setNumerator: 3];
        [frac2 setDenominator: 7];
        
        NSLog(@"The frac1 value of myFraction is:");
        [frac1 print];

        NSLog(@"The frac2 value of myFraction is:");
        [frac2 print];
    }
    return 0;
}

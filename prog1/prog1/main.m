//
//  main.m
//  prog1
//
//  Created by OA Wu on 2015/4/27.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "Fraction.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Fraction *myFrac1 = [[Fraction alloc] init];

        myFrac1.numerator = 1;
        myFrac1.denominator = 4;
        
        NSLog(@"%i / %i = %g", myFrac1.numerator, myFrac1.denominator, myFrac1.covertToNum);
    }
    return 0;
}

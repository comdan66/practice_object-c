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

        [myFrac1 setNumerator: 1];
        [myFrac1 setDenominator: 4];
        
        NSLog(@"val: ");
        [myFrac1 print];
    }
    return 0;
}

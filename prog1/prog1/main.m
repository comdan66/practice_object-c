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
        Fraction *myFrac2 = [[Fraction alloc] init];

        myFrac1.numerator = 1;
        myFrac1.denominator = 4;
        
        myFrac2.numerator = 2;
        myFrac2.denominator = 3;
        
        [myFrac1 print];
        [myFrac2 print];
        
        [myFrac1 add: myFrac2];
        [myFrac1 print];
        
        NSLog(@"val: %g", myFrac1.covertToNum);
        //
//        myFrac1.numerator = 1;
//        myFrac1.denominator = 4;
//        
//        NSLog(@"%i / %i = %g", myFrac1.numerator, myFrac1.denominator, myFrac1.covertToNum);
//        
//        [myFrac1 setTo: 1 over: 3];
//        [myFrac1 print];
    }
    return 0;
}

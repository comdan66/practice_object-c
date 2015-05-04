//
//  main.m
//  sample9
//
//  Created by OA Wu on 2015/5/4.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "Complex.h"
#import "Fraction.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Fraction* f1 = [Fraction new];
        Fraction* f2 = [Fraction new];
        Fraction* fr;
        
        Complex* c1 = [Complex new];
        Complex* c2 = [Complex new];
        Complex* cr;
        
        [f1 setTo: 2 over: 10];
        [f2 setTo: 2 over: 15];
        [c1 setReal: 18.0 andImaginary: 2.5];
        [c2 setReal: -5.0 andImaginary: 3.2];
        
        [c1 print];
        NSLog(@"        +");
        [c2 print];
        NSLog(@"---------");
        fr = [c1 add: c2];
        [fr print];
        
        NSLog(@"===============");
        
        [f1 print];
        NSLog(@"      +");
        [f2 print];
        NSLog(@"-------");
        fr = [f1 add: f2];
        [fr print];
        
    }
    return 0;
}

//
//  main.m
//  prog1
//
//  Created by OA Wu on 2015/4/27.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        int integerVar = 100;
        float floatingVar = 331.79;
        double doubleVar = 8.44e+11;
        char charVar = 'w';
        
        NSLog(@"integer value = %i", integerVar);
        NSLog(@"float value = %f", floatingVar);
        NSLog(@"double value = %e", doubleVar);
        NSLog(@"double value = %g", doubleVar);
        NSLog(@"char value = %c", charVar);
    }
    return 0;
}

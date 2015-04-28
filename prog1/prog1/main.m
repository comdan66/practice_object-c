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
        int integer = 0;
        
        for (int n = 1; n <= 200; n++) {
            integer += n;
        }
        
        NSLog(@"val: %i", integer);
    }
    return 0;
}

//
//  main.m
//  prog1
//
//  Created by OA Wu on 2015/4/27.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassA : NSObject {
    int x;
}

-(void) initVar;

@end

@implementation ClassA

-(void) initVar {
    x = 100;
}

@end

@interface ClassB : ClassA

-(void) printVal;

@end

@implementation ClassB

-(void) printVal {
    NSLog(@"X = %i", x);
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        ClassB* b = [ClassB new];
        
        [b initVar];
        [b printVal];
    }
    return 0;
}

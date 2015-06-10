//
//  main.m
//  restart
//
//  Created by OA Wu on 2015/6/10.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "User.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        User *user = [User new];
        
        [user setAge: 10];
        int age = [user age];
        
        NSLog (@"User age: %i", age);
    }
    return 0;
}

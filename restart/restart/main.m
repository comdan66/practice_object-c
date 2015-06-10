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
        
        user.age = 10;
        user.name = @"OA";
        
        NSLog (@"User name: %@", user.name);
        NSLog (@"User age: %i", user.age);
    }
    return 0;
}

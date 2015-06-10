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
        User *oa = [User new];
        
        oa.age = 30;
        oa.name = @"OA";
        
        NSLog (@"OA name: %@", oa.name);
        NSLog (@"OA age: %i", oa.age);
        
        oa.children = [User new];
        oa.children.name = @"OB";
        oa.children.age = 10;
        
        NSLog(@"OA Children name %@", oa.children.name);
        NSLog(@"OA Children age %i", oa.children.age);
        
        
    }
    return 0;
}

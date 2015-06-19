//
//  User.m
//  restart
//
//  Created by OA Wu on 2015/6/10.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize age, name, nextUser;

-(void) addUser: (User*) u {
    if (self.nextUser == nil)
        nextUser = u;
    else
        [self.nextUser addUser: u];
}

-(void) printAll {
    NSLog(@"Name: %@", self.name);
    NSLog(@"Age: %i", self.age);
    NSLog(@"======================");
    
    if (self.nextUser != nil)
        [self.nextUser printAll];
}

@end

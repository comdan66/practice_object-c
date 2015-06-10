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
        User *users;
        


        NSString* userInput;
        do {
            NSLog(@"Please input name(0 to stop): ");
            char word [40];
            scanf("%s", word);
            userInput = [[NSString alloc] initWithCString: word encoding: NSUTF8StringEncoding];
            
            if ([userInput  isEqual: @"0"])
                break;

            User *user = [User new];
            user.name = userInput;
            user.age = 0;
            user.nextUser = nil;
            
            if (users == nil)
                users = user;
            else
                [users addUser: user];

        } while (true);
        
        
        [users printAll];

        
        
    }
    return 0;
}

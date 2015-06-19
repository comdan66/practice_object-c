//
//  User.h
//  restart
//
//  Created by OA Wu on 2015/6/10.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property int age;
@property NSString* name;
@property User* nextUser;

-(void) addUser: (User*) u;
-(void) printAll;

@end

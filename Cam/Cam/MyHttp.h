//
//  MyHttp.h
//  OA_1.5
//
//  Created by OA Wu on 2015/6/16.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyHttp : NSObject

-(NSString *)urlencode:(NSString *)input;
-(void)postURL:(NSString *)urlStr vars:(NSDictionary *)vars completionHandler:(void (^)(NSURLResponse* response, NSData* data, NSError* connectionError)) handler;
-(void)getURL:(NSString *)urlStr vars:(NSDictionary *)vars completionHandler:(void (^)(NSURLResponse* response, NSData* data, NSError* connectionError)) handler;
- (void)postMulti:(NSString *)urlStr vars:(NSDictionary *)vars files:(NSArray *)files completionHandler:(void (^)(NSURLResponse* response, NSData* data, NSError* connectionError)) handler;
@end

//
//  OaHttp.m
//  OA_1.2
//
//  Created by OA Wu on 2015/6/16.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "OaHttp.h"

@implementation OaHttp

-(NSString *)urlencode:(NSString *)input {
    const char *input_c = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSMutableString *result = [NSMutableString new];
    for (NSInteger i = 0, len = strlen(input_c); i < len; i++) {
        unsigned char c = input_c[i];
        if ((c >= '0' && c <= '9') || (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') || c == '-' || c == '.' || c == '_' || c == '~') {
            [result appendFormat:@"%c", c];
        }
        else {
            [result appendFormat:@"%%%02X", c];
        }
    }
    return result;
    }

    -(void)postURL:(NSString *)urlStr vars:(NSDictionary *)vars completionHandler:(void (^)(NSURLResponse* response, NSData* data, NSError* connectionError)) handler {

    NSMutableString *varStr = [NSMutableString new];

    if ((vars != nil) && (vars.count > 0)) {
        for (NSString *key in vars) {
            if ([varStr length] > 0) {
                [varStr appendString:@"&"];
            }
            
            [varStr appendString:[self urlencode:key]];
            [varStr appendString:@"="];
            [varStr appendString:[self urlencode:[vars valueForKey:key]]];
        }
    }
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[varStr dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPShouldHandleCookies:NO];
    [request setValue:@"Agent name goes here" forHTTPHeaderField:@"User-Agent"];
    
    NSOperationQueue *requestQueue = [NSOperationQueue new];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:requestQueue
                           completionHandler:handler];
}
-(void)getURL:(NSString *)urlStr vars:(NSDictionary *)vars completionHandler:(void (^)(NSURLResponse* response, NSData* data, NSError* connectionError)) handler {
    NSMutableString *urlWithVarsStr = [NSMutableString stringWithString:urlStr];
    
    if ((vars != nil) && (vars.count > 0)) {
        for (NSString *key in vars) {
            [urlWithVarsStr appendString:([urlWithVarsStr length] == [urlStr length] ? @"?" : @"&")];
            [urlWithVarsStr appendString:[self urlencode:key]];
            [urlWithVarsStr appendString:@"="];
            [urlWithVarsStr appendString:[self urlencode:[vars valueForKey:key]]];
        }
    }
    
    NSURL *url = [NSURL URLWithString:urlWithVarsStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"GET"];
    [request setHTTPShouldHandleCookies:NO];
    [request setValue:@"Agent name goes here" forHTTPHeaderField:@"User-Agent"];

    NSOperationQueue *requestQueue = [NSOperationQueue new];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:requestQueue
                           completionHandler:handler];
}
@end

//
//  MyHttp.m
//  OA_1.5
//
//  Created by OA Wu on 2015/6/16.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "MyHttp.h"

@implementation MyHttp

-(NSString *)urlencode:(NSString *)input {
    const char *input_c = [[[NSString alloc] initWithFormat:@"%@", input] cStringUsingEncoding:NSUTF8StringEncoding];
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
















- (NSString *)http_attribute_encode:(NSString *)input attribute_name:(NSString *)attribute_name {
    // result structure follows RFC 5987
    BOOL need_utf_encoding = NO;
    NSMutableString *result = [NSMutableString new];
    const char *input_c = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSInteger i;
    NSInteger len = strlen(input_c);
    unsigned char c;

    for (i = 0; i < len; i++) {
        c = input_c[i];
        if (c == '\\' || c == '/' || c == '\0' || c < ' ' || c > '~') {
            // ignore and request utf-8 version
            need_utf_encoding = YES;
        }
        else if (c == '"') {
            [result appendString:@"\\\""];
        }
        else {
            [result appendFormat:@"%c", c];
        }
    }
    
    if (result.length == 0) {
        need_utf_encoding = YES;
        [result appendString:@"file"];
    }
    
    if (!need_utf_encoding) {
        // return a simple version
        return [NSString stringWithFormat:@"%@=\"%@\"", attribute_name, result];
    }
    
    NSMutableString *result_utf8 = [NSMutableString new];
    for (i = 0; i < len; i++) {
        c = input_c[i];
        if ((c >= '0' && c <= '9')
            || (c >= 'A' && c <= 'Z')
            || (c >= 'a' && c <= 'z')
            ) {
            [result_utf8 appendFormat:@"%c", c];
        }
        else {
            [result_utf8 appendFormat:@"%%%02X", c];
        }
    }
    
    // return enhanced version with UTF-8 support
    return [NSString stringWithFormat:@"%@=\"%@\"; %@*=utf-8''%@", attribute_name, result, attribute_name, result_utf8];
}

- (void)postMulti:(NSString *)urlStr vars:(NSDictionary *)vars files:(NSArray *)files completionHandler:(void (^)(NSURLResponse* response, NSData* data, NSError* connectionError)) handler {
//    NSString *str;
    NSMutableData *data = [NSMutableData new];
    
    NSMutableString *boundary = [NSMutableString new];
    [boundary appendFormat:@"__---%ld_%ld", arc4random() % 2147483648, (long) ([[NSDate new] timeIntervalSince1970] * 1000)];
    
    NSData *boundaryBody = [boundary dataUsingEncoding:NSUTF8StringEncoding];
    NSData *boundaryDelimiter = [@"--" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *newLine = [@"\r\n" dataUsingEncoding:NSUTF8StringEncoding];
    
    // add variables
    if (vars != nil) {
        for (NSString *key in vars) {
            // add boundary
            [data appendData:boundaryDelimiter];
            [data appendData:boundaryBody];
            [data appendData:newLine];
            
            // add header
            [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; %@", [self http_attribute_encode:key attribute_name:@"name"]] dataUsingEncoding:NSUTF8StringEncoding]];
            [data appendData:newLine];
            
            [data appendData:[@"Content-Type: text/plain" dataUsingEncoding:NSUTF8StringEncoding]];
            [data appendData:newLine];
            
            // add header to body splitter
            [data appendData:newLine];
            
            // add variable content
            [data appendData:[[vars valueForKey:key] dataUsingEncoding:NSUTF8StringEncoding]];
            [data appendData:newLine];
        }
    }
    
    // add files
    if (files != nil) {
        for (NSInteger i = 0; i < files.count; i++) {
            NSMutableDictionary *fileParameters = [files objectAtIndex:i];
            
            NSString *name = [fileParameters objectForKey:@"name"];
            NSString *mime_type = [fileParameters objectForKey:@"mime_type"];
            NSString *local_filename = [fileParameters objectForKey:@"local_filename"];
            
            
            if (!((name != nil) &&
                 (name.length != 0) &&
                 (local_filename != 0) &&
                 (local_filename.length != 0) &&
                 [[NSFileManager defaultManager] fileExistsAtPath:local_filename] &&
                 ([local_filename lastPathComponent].length != 0)))
                continue;
            
            NSString *request_filename = [local_filename lastPathComponent];
            
            // add boundary
            [data appendData:boundaryDelimiter];
            [data appendData:boundaryBody];
            [data appendData:newLine];
            

            [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; %@; %@",
                               [self http_attribute_encode:name attribute_name:@"name"],
                               [self http_attribute_encode:request_filename attribute_name:@"filename"]
                               ] dataUsingEncoding:NSUTF8StringEncoding]];
            [data appendData:newLine];
            
            if (mime_type != nil && mime_type.length > 0) {
                [data appendData:[[NSString stringWithFormat:@"Content-Type: %@", mime_type] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:newLine];
            }
            
            [data appendData:[@"Content-Transfer-Encoding: binary" dataUsingEncoding:NSUTF8StringEncoding]];
            [data appendData:newLine];
            
            // add header to body splitter
            [data appendData:newLine];
            
            // add file content
            [data appendData:[NSData dataWithContentsOfFile:local_filename]];
            [data appendData:newLine];
        }
    }
    
    // add end of body
    [data appendData:boundaryDelimiter];
    [data appendData:boundaryBody];
    [data appendData:boundaryDelimiter];

    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    [request setHTTPShouldHandleCookies:NO];
    [request setValue:@"Agent name goes here" forHTTPHeaderField:@"User-Agent"];
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary] forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:data];
    
    
    
    
    NSOperationQueue *requestQueue = [NSOperationQueue new];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:requestQueue
                           completionHandler:handler];
}

- (NSString *)getMimeType:(NSData *)data {
    
    char bytes[12] = {0};
    [data getBytes:&bytes length:12];
    
    const char bmp[2] = {'B', 'M'};
    const char gif[3] = {'G', 'I', 'F'};
    const char jpg[3] = {0xff, 0xd8, 0xff};
    const char psd[4] = {'8', 'B', 'P', 'S'};
    const char iff[4] = {'F', 'O', 'R', 'M'};
    const char webp[4] = {'R', 'I', 'F', 'F'};
    const char ico[4] = {0x00, 0x00, 0x01, 0x00};
    const char tif_ii[4] = {'I','I', 0x2A, 0x00};
    const char tif_mm[4] = {'M','M', 0x00, 0x2A};
    const char png[8] = {0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a};
    const char jp2[12] = {0x00, 0x00, 0x00, 0x0c, 0x6a, 0x50, 0x20, 0x20, 0x0d, 0x0a, 0x87, 0x0a};
    
    
    if (!memcmp(bytes, bmp, 2)) {
        return @"image/x-ms-bmp";
    } else if (!memcmp(bytes, gif, 3)) {
        return @"image/gif";
    } else if (!memcmp(bytes, jpg, 3)) {
        return @"image/jpeg";
    } else if (!memcmp(bytes, psd, 4)) {
        return @"image/psd";
    } else if (!memcmp(bytes, iff, 4)) {
        return @"image/iff";
    } else if (!memcmp(bytes, webp, 4)) {
        return @"image/webp";
    } else if (!memcmp(bytes, ico, 4)) {
        return @"image/vnd.microsoft.icon";
    } else if (!memcmp(bytes, tif_ii, 4) || !memcmp(bytes, tif_mm, 4)) {
        return @"image/tiff";
    } else if (!memcmp(bytes, png, 8)) {
        return @"image/png";
    } else if (!memcmp(bytes, jp2, 12)) {
        return @"image/jp2";
    }
    
    return @"application/x-www-form-urlencoded"; // default type
    
}

- (void)postMulti:(NSString *)urlStr vars:(NSDictionary *)vars datas:(NSArray *)datas completionHandler:(void (^)(NSURLResponse* response, NSData* data, NSError* connectionError)) handler {
    //    NSString *str;
    NSMutableData *data = [NSMutableData new];
    
    NSMutableString *boundary = [NSMutableString new];
    [boundary appendFormat:@"__---%ld_%ld", arc4random() % 2147483648, (long) ([[NSDate new] timeIntervalSince1970] * 1000)];
    
    NSData *boundaryBody = [boundary dataUsingEncoding:NSUTF8StringEncoding];
    NSData *boundaryDelimiter = [@"--" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *newLine = [@"\r\n" dataUsingEncoding:NSUTF8StringEncoding];
    
    // add variables
    if (vars != nil) {
        for (NSString *key in vars) {
            // add boundary
            [data appendData:boundaryDelimiter];
            [data appendData:boundaryBody];
            [data appendData:newLine];
            
            // add header
            [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; %@", [self http_attribute_encode:key attribute_name:@"name"]] dataUsingEncoding:NSUTF8StringEncoding]];
            [data appendData:newLine];
            
            [data appendData:[@"Content-Type: text/plain" dataUsingEncoding:NSUTF8StringEncoding]];
            [data appendData:newLine];
            
            // add header to body splitter
            [data appendData:newLine];
            
            // add variable content
            [data appendData:[[vars valueForKey:key] dataUsingEncoding:NSUTF8StringEncoding]];
            [data appendData:newLine];
        }
    }
    
    // add files
    if (datas != nil) {
        for (NSInteger i = 0; i < datas.count; i++) {
            NSDictionary *d = [datas objectAtIndex:i];
            
            NSString *name = [d objectForKey:@"name"];
            NSData *postData = [d objectForKey:@"data"];
            NSString *mime_type = [self getMimeType:postData];

            NSString *request_filename = [[NSUUID UUID] UUIDString];
            
            // add boundary
            [data appendData:boundaryDelimiter];
            [data appendData:boundaryBody];
            [data appendData:newLine];
            
            
            [data appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; %@; %@",
                               [self http_attribute_encode:name attribute_name:@"name"],
                               [self http_attribute_encode:request_filename attribute_name:@"filename"]
                               ] dataUsingEncoding:NSUTF8StringEncoding]];
            [data appendData:newLine];
            
            if (mime_type != nil && mime_type.length > 0) {
                [data appendData:[[NSString stringWithFormat:@"Content-Type: %@", mime_type] dataUsingEncoding:NSUTF8StringEncoding]];
                [data appendData:newLine];
            }
            
            [data appendData:[@"Content-Transfer-Encoding: binary" dataUsingEncoding:NSUTF8StringEncoding]];
            [data appendData:newLine];
            
            // add header to body splitter
            [data appendData:newLine];
            
            // add file content
            [data appendData:postData];
            [data appendData:newLine];
        }
    }
    
    // add end of body
    [data appendData:boundaryDelimiter];
    [data appendData:boundaryBody];
    [data appendData:boundaryDelimiter];
    
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    [request setHTTPShouldHandleCookies:NO];
    [request setValue:@"Agent name goes here" forHTTPHeaderField:@"User-Agent"];
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary] forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:data];
    
    
    
    
    NSOperationQueue *requestQueue = [NSOperationQueue new];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:requestQueue
                           completionHandler:handler];
}



@end

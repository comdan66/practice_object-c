//
//  ViewController.m
//  OA
//
//  Created by OA Wu on 2015/6/13.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self->isLogin = NO;
//    NSLog(@"%02i", 5);
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSString *)urlencode:(NSString *)input {
    const char *input_c = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSMutableString *result = [NSMutableString new];
    for (NSInteger i = 0, len = strlen(input_c); i < len; i++) {
        unsigned char c = input_c[i];
        if (
            (c >= '0' && c <= '9')
            || (c >= 'A' && c <= 'Z')
            || (c >= 'a' && c <= 'z')
            || c == '-' || c == '.' || c == '_' || c == '~'
            ) {
            [result appendFormat:@"%c", c];
        }
        else {
            [result appendFormat:@"%%%02X", c];
        }
    }
    return result;
}

- (void)send_url_encoded_http_post_request:(NSString *)url_str vars:(NSDictionary *)vars {
    NSMutableString *vars_str = [NSMutableString new];
    if (vars != nil && vars.count > 0) {
        BOOL first = YES;
        for (NSString *key in vars) {
            if (!first) {
                [vars_str appendString:@"&"];
            }
            first = NO;
            
            [vars_str appendString:[self urlencode:key]];
            [vars_str appendString:@"="];
            [vars_str appendString:[self urlencode:[vars valueForKey:key]]];
        }
    }
    
    NSURL *url = [NSURL URLWithString:url_str];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPShouldHandleCookies:NO];
    [request setValue:@"Agent name goes here" forHTTPHeaderField:@"User-Agent"];
    [request setHTTPBody:[vars_str dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (IBAction)loginButton:(id)sender {
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Loading..." message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [myAlertView show];
    
//    NSString *post = [NSString stringWithFormat:@"Username=%@&Password=%@",@"username",@"password"];
    
    
    NSURL *url = [NSURL URLWithString:@"http://ios.ioa.tw/"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    NSData *data = [@"account=oa&password=123" dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    
    NSOperationQueue *requestQueue = [NSOperationQueue new];
    
    [NSURLConnection sendAsynchronousRequest:request queue:requestQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSDictionary *jsonDict = [str JSONValue];
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"result:%@", result);
//        NSLog(@"%@", str);
//        self->isLogin = (BOOL)[result objectForKey:@"status"];
        self->isLogin = [result[@"status"] boolValue];
        NSLog(@"%@", self->isLogin ? @"yes":@"no");

        dispatch_async(dispatch_get_main_queue(), ^{
            [myAlertView dismissWithClickedButtonIndex:-1 animated:YES];
            if (self->isLogin == YES) {
                UIAlertView *ok = [[UIAlertView alloc] initWithTitle:@"登入成功！" message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:@"確定", nil];
                [ok show];
            } else {
                UIAlertView *ok = [[UIAlertView alloc] initWithTitle:@"登入失敗！" message:@"" delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
                [ok show];
            
            }
        });
    }];
//
//    NSOperationQueue *queur = [NSOperationQueue new];
//    [queur addOperationWithBlock:^{
//        [myAlertView dismissWithClickedButtonIndex:-1 animated:YES];
//    }];
    
//    UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleRed];
//    loading.frame=CGRectMake(150, 150, 16, 16);
//    [myAlertView addSubview:loading];

    
//    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"logined"];
//    
//    [self showDetailViewController:vc sender:self];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == [alertView cancelButtonIndex]){
    } else if (buttonIndex == [alertView firstOtherButtonIndex]) {
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"logined"];
        [self showDetailViewController:vc sender:self];
    }
}


@end

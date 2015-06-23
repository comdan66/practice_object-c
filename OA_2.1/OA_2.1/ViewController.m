//
//  ViewController.m
//  OA_2.1
//
//  Created by OA Wu on 2015/6/23.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImage *img = [UIImage imageNamed:@"upload.jpg"];
    
    NSData *imageData = UIImageJPEGRepresentation(img,0.2);
    
    //上傳所需資訊
    NSMutableDictionary *data = [[NSMutableDictionary alloc]init];
    [data setValue:@"xxx" forKey:@"text"];

    //上傳網址
    NSString *urlString = [NSString stringWithFormat:@"http://ios.ioa.tw/api/v1/test"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [manager POST:urlString parameters:data constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
            [formData appendPartWithFileData:imageData name:@"file" fileName:@"fg.jpg" mimeType:@"image/jepg"];
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"responseObject : %@",responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"圖片上傳error=%@",error);
        }
     ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

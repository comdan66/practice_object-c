//
//  ViewController.m
//  remember
//
//  Created by OA Wu on 2015/7/30.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize count, eventId;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [CLLocationManager new];
    [self.locationManager setDelegate:self];
    [self.locationManager requestAlwaysAuthorization];
    self.locationManager.distanceFilter = 1;
    
    [self.statusButton addTarget:self action:@selector(statusButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self setCount:0];
    [self setEventId:@"0"];
    

    
    NSMutableDictionary *data = [NSMutableDictionary new];
    [data setValue:@"test" forKey:@"title"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"application/json"]];
    [manager POST:[NSString stringWithFormat:@"http://map.ioa.tw/api/create_event"]
      parameters:data
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             if ([[responseObject objectForKey:@"status"] boolValue]) {
                 eventId = [responseObject objectForKey:@"id"];
                 [self.messageLabel setText:[NSString stringWithFormat:@"成功，ID：%@", eventId]];
                 [self.locationManager startUpdatingLocation];
                 [self.statusButton setTitle:@"開始" forState:UIControlStateNormal];
             } else {
                 [self.messageLabel setText:@"create_event API 回傳失敗!"];
             }
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [self.messageLabel setText:@"呼叫 create_event API 失敗!"];
         }
     ];
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)statusButtonAction:(UIButton*)sender {
    if ([sender.titleLabel.text isEqualToString:@"開始"]) {
        [self.locationManager stopUpdatingLocation];
        [self.statusButton setTitle:@"關閉" forState:UIControlStateNormal];
        [self.subMessageLabel setText:@"關閉定位!"];
    } else {
        if ([eventId integerValue] > 0) {
            [self.locationManager startUpdatingLocation];
            [self.statusButton setTitle:@"開始" forState:UIControlStateNormal];
            [self.subMessageLabel setText:@"開啟定位!"];
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations firstObject];
    
    [self.latTextField setText:[NSString stringWithFormat:@"%f", location.coordinate.latitude]];
    [self.lngTextField setText:[NSString stringWithFormat:@"%f", location.coordinate.longitude]];
    
    [self.countTextField setText:[NSString stringWithFormat:@"%d", count++]];
    
    NSMutableDictionary *data = [NSMutableDictionary new];
    [data setValue:eventId forKey:@"event_id"];
    [data setValue:[NSString stringWithFormat:@"%f", location.coordinate.latitude] forKey:@"latitude"];
    [data setValue:[NSString stringWithFormat:@"%f", location.coordinate.longitude] forKey:@"longitude"];

    
    AFHTTPRequestOperationManager *manager2 = [AFHTTPRequestOperationManager manager];
    [manager2.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"application/json"]];
    [manager2 POST:[NSString stringWithFormat:@"http://map.ioa.tw/api/update_marker"]
       parameters:data
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([[responseObject objectForKey:@"status"] boolValue]) {
                  [self.subMessageLabel setText:@"update_marker API 回傳成功!"];
              } else {
                  [self.subMessageLabel setText:@"update_marker API 回傳失敗!"];
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [self.subMessageLabel setText:@"呼叫 update_marker API 失敗!"];
          }
     ];
    
}

@end

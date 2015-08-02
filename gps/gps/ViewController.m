//
//  ViewController.m
//  gps
//
//  Created by OA Wu on 2015/7/31.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [CLLocationManager new];
    [self.locationManager setDelegate:self];
    [self.locationManager setDistanceFilter:[self.sliderLabel.text doubleValue]];
    [self.locationManager requestAlwaysAuthorization];
    
    [self.logTextView.layer setBorderColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.4].CGColor];
    [self.logTextView.layer setBorderWidth:1.0f / [UIScreen mainScreen].scale];
    [self.logTextView.layer setCornerRadius:2];
    [self.logTextView setClipsToBounds:YES];
    
    self.app = (AppDelegate *)[[UIApplication sharedApplication] delegate];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)log:(NSString *)text {
    [self.logTextView insertText:[NSString stringWithFormat:@"  %@\n", text]];
    [self.logTextView scrollRangeToVisible:NSMakeRange(self.logTextView.text.length - 1, 1)];
}
- (void)logLine {
    [self log:@"\n---------------------\n"];
}
- (void)logDbLine {
    [self log:@"\n=====================\n"];
}
- (void)initEventId {
    [self logLine];
    [self log:@"取得 Event ID 中.."];
    
    NSMutableDictionary *data = [NSMutableDictionary new];
    [data setValue:@"test" forKey:@"name"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"application/json"]];
    [manager POST:[NSString stringWithFormat:@"http://maps.ioa.tw/api/ios/create_event"]
       parameters:data
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([[responseObject objectForKey:@"status"] boolValue]) {
                  self.eventId = [responseObject objectForKey:@"id"];
                  [self log:@"取得 Event ID 成功！"];
                  [self log:[NSString stringWithFormat:@"Event ID：%@", self.eventId]];
                  [self startGPS];
              } else {
                  [self log:@"create_event API 回傳失敗!"];
                  [self.statusSwitch setOn:NO animated:YES];
                  [self stopGPS];
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"error code %@",operation.response);
              
              [self log:@"呼叫 create_event API 失敗！"];
              [self.statusSwitch setOn:NO animated:YES];
              [self stopGPS];
          }
     ];
    
}
- (void)startGPS {
    [self logLine];
    [self log:@"開啟 GPS 中.."];
    [self.statusSwitch setOn:NO animated:YES];
    
    if (!self.eventId || ([self.eventId integerValue] < 1)) {
        [self log: @"沒有 Event ID"];
        [self log: @"初始化 Event ID"];
        [self initEventId];
    } else {
        [self log: @"有 Event ID"];
        [self.locationManager startUpdatingLocation];
        [self.statusSwitch setOn:YES animated:YES];
        [self.statusLabel setText:@"開啟"];
        [self log: @"開啟 GPS 紀錄"];
    }
}
- (void)stopGPS {
    [self.locationManager stopUpdatingLocation];

    [self logLine];
    [self log:@"關閉 GPS 紀錄"];
    [self.statusLabel setText:@"關閉"];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    [self logLine];
    [self log:@"取得紀錄"];
    
    CLLocation *location = [locations firstObject];
    NSString *lat = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
    NSString *lng = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
    NSString *altitude = [NSString stringWithFormat:@"%f", location.altitude];
    NSString *horizontalAccuracy = [NSString stringWithFormat:@"%f", location.horizontalAccuracy];
    NSString *verticalAccuracy = [NSString stringWithFormat:@"%f", location.verticalAccuracy];
    NSString *speed = [NSString stringWithFormat:@"%f", location.speed];
    NSString *count = [NSString stringWithFormat:@"%d", self.count++];
    
    [self log:[NSString stringWithFormat:@"緯度：%@", lat]];
    [self log:[NSString stringWithFormat:@"經度：%@", lng]];
    [self log:[NSString stringWithFormat:@"海拔：%@", altitude]];
    [self log:[NSString stringWithFormat:@"水平準度：%@", horizontalAccuracy]];
    [self log:[NSString stringWithFormat:@"垂直準度：%@", verticalAccuracy]];
    [self log:[NSString stringWithFormat:@"速度：%@", speed]];
    [self log:[NSString stringWithFormat:@"次數：%@", count]];
    

    
    Markers *marker = [NSEntityDescription insertNewObjectForEntityForName:@"Markers" inManagedObjectContext:self.app.managedObjectContext];

    marker.id = [NSNumber numberWithInt:self.count];
    marker.lat = lat;
    marker.lng = lng;
    marker.altitude = altitude;
    marker.horizontalAccuracy = horizontalAccuracy;
    marker.verticalAccuracy = verticalAccuracy;
    marker.speed = speed;
    
    [self.app.managedObjectContext save:nil];

//    NSMutableDictionary *data = [NSMutableDictionary new];
//    [data setValue:self.eventId forKey:@"event_id"];
//    [data setValue:lat forKey:@"latitude"];
//    [data setValue:lng forKey:@"longitude"];
//    
//    AFHTTPRequestOperationManager *httpManager = [AFHTTPRequestOperationManager manager];
//    [httpManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"application/json"]];
//    [httpManager POST:[NSString stringWithFormat:@"http://map.ioa.tw/api/update_marker"]
//        parameters:data
//           success:^(AFHTTPRequestOperation *operation, id responseObject) {
//               if ([[responseObject objectForKey:@"status"] boolValue]) {
//                   [self log:@"上傳 update_marker API 回傳成功"];
//               } else {
//                   [self log:@"上傳 update_marker API 回傳失敗!"];
//               }
//           }
//           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//               [self log:@"呼叫 update_marker API 失敗!"];
//           }
//     ];
    
}
- (IBAction)sqliteButtonAction:(id)sender {
    [self logLine];
    [self log:@"印出 SQLite"];
    
    NSFetchRequest *fetch = [NSFetchRequest new];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Markers" inManagedObjectContext:self.app.managedObjectContext];
    [fetch setEntity:entity];
    
    [fetch setSortDescriptors:[[NSArray alloc] initWithObjects:[[NSSortDescriptor alloc] initWithKey:@"id" ascending:YES], nil]];
    NSArray *markers = [self.app.managedObjectContext executeFetchRequest:fetch error:nil];
    
    int index = 0;
    NSMutableDictionary *data = [NSMutableDictionary new];
    [data setValue:self.eventId forKey:@"event_id"];

    for (Markers *marker in markers) {
        [self log:[NSString stringWithFormat:@"count：%@", marker.id]];
        [self log:[NSString stringWithFormat:@"lat：%@", marker.lat]];
        [self log:[NSString stringWithFormat:@"lng：%@", marker.lng]];
        [self log:[NSString stringWithFormat:@"altitude：%@", marker.altitude]];
        [self log:[NSString stringWithFormat:@"horizontalAccuracy：%@", marker.horizontalAccuracy]];
        [self log:[NSString stringWithFormat:@"verticalAccuracy：%@", marker.verticalAccuracy]];
        [self log:[NSString stringWithFormat:@"speed：%@", marker.speed]];
        
        
        [data setValue:[NSString stringWithFormat:@"%@", marker.id] forKey:[NSString stringWithFormat:@"polylines[%d][count]", index]];
        [data setValue:marker.lat forKey:[NSString stringWithFormat:@"polylines[%d][lat]", index]];
        [data setValue:marker.lng forKey:[NSString stringWithFormat:@"polylines[%d][lng]", index]];
        [data setValue:marker.altitude forKey:[NSString stringWithFormat:@"polylines[%d][altitude]", index]];
        [data setValue:marker.horizontalAccuracy forKey:[NSString stringWithFormat:@"polylines[%d][accuracy_h]", index]];
        [data setValue:marker.verticalAccuracy forKey:[NSString stringWithFormat:@"polylines[%d][accuracy_v]", index]];
        [data setValue:marker.speed forKey:[NSString stringWithFormat:@"polylines[%d][speed]", index]];
        
        [self.app.managedObjectContext deleteObject:marker];
        [self.app.managedObjectContext save:nil];
        index++;
        [self log:@"------------------"];
    }
    
    [self logDbLine];
    [self log:@"上傳 Polylines"];
    AFHTTPRequestOperationManager *httpManager = [AFHTTPRequestOperationManager manager];
    [httpManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"application/json"]];
    [httpManager POST:[NSString stringWithFormat:@"http://maps.ioa.tw/api/ios/update_polylines"]
        parameters:data
           success:^(AFHTTPRequestOperation *operation, id responseObject) {

               if ([[responseObject objectForKey:@"status"] boolValue]) {
                   [self log:@"上傳 update_polylines API 回傳成功"];
               } else {
                   [self log:@"上傳 update_polylines API 回傳失敗!"];
               }
           }
           failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               [self log:@"呼叫 update_polylines API 失敗!"];
           }
     ];
    

}
- (IBAction)sliderChange:(UISlider *)sender {
    int distance = (int)round(sender.value);
    [self.sliderLabel setText:[NSString stringWithFormat:@"%d", distance]];
    [self.locationManager setDistanceFilter:distance];
    [self log:[NSString stringWithFormat:@"更新 distance：%d", distance]];
}

- (IBAction)switchChange:(UISwitch *)sender {
    if ([sender isOn])
        [self startGPS];
    else
        [self stopGPS];
}

@end

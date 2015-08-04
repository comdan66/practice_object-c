//
//  ViewController.m
//  GPS2
//
//  Created by OA Wu on 2015/8/2.
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
    [self.locationManager setDistanceFilter:[self.steperLabel.text doubleValue]];
    [self.locationManager requestAlwaysAuthorization];

    [self.logTextView.layer setBorderColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.4].CGColor];
    [self.logTextView.layer setBorderWidth:1.0f / [UIScreen mainScreen].scale];
    [self.logTextView.layer setCornerRadius:2];
    [self.logTextView setClipsToBounds:YES];
    
    self.isUpload = NO;
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.db = [app getDB];
    
//    if (self.db != nil) {
//        const char *sql = "SELECT * FROM polylines";
//        sqlite3_stmt *statement;
//        sqlite3_prepare(self.db, sql, -1, &statement, NULL);
//        
//        while (sqlite3_step(statement) == SQLITE_ROW) {
//            char *id = (char *)sqlite3_column_text(statement, 0);
//            char *lat = (char *)sqlite3_column_text(statement, 1);
//            char *lng = (char *)sqlite3_column_text(statement, 2);
//            
//            NSLog(@"id: %@", [NSString stringWithCString:id encoding:NSUTF8StringEncoding]);
//            NSLog(@"lat: %@", [NSString stringWithCString:lat encoding:NSUTF8StringEncoding]);
//            NSLog(@"lng: %@", [NSString stringWithCString:lng encoding:NSUTF8StringEncoding]);
//            
//        }
//        
//        sqlite3_finalize(statement);
////    }
//    if (self.db != nil) {
//        const char *sql = "SELECT COUNT(id) FROM polylines";
//        sqlite3_stmt *statement;
//        sqlite3_prepare(self.db, sql, -1, &statement, NULL);
//        
//        while (sqlite3_step(statement) == SQLITE_ROW) {
//            char *count = (char *)sqlite3_column_text(statement, 0);
//            
//            NSLog(@"count: %@", [NSString stringWithCString:count encoding:NSUTF8StringEncoding]);
//            
//        }
//        
//        sqlite3_finalize(statement);
//    }
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initEventId:(void (^)(id eventId)) success failure: (void (^)(NSString *msg)) failure{
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
                  success([responseObject objectForKey:@"id"]);
              } else {
                  failure(@"create_event API 回傳失敗!");
              }
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              failure(@"create_event API 回傳失敗!");
          }
     ];
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    if (!self.eventId) {
        [self logLine];
        [self log:@"尚未取得 EventID!"];
        return;
    }
        
    CLLocation *location = [locations firstObject];

    NSString *lat = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
    NSString *lng = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
    NSString *altitude = [NSString stringWithFormat:@"%f", location.altitude];
    NSString *horizontalAccuracy = [NSString stringWithFormat:@"%f", location.horizontalAccuracy];
    NSString *verticalAccuracy = [NSString stringWithFormat:@"%f", location.verticalAccuracy];
    NSString *speed = [NSString stringWithFormat:@"%f", location.speed];
    
    if ((location.horizontalAccuracy > 200) || (location.verticalAccuracy > 200)) {
        [self logLine];
        [self log:@"準確度超出範圍!"];
        return;
    }
    
    [self logLine];
    [self log:@"取得紀錄"];
    [self log:[NSString stringWithFormat:@"緯度：%@", lat]];
    [self log:[NSString stringWithFormat:@"經度：%@", lng]];
    [self log:[NSString stringWithFormat:@"海拔：%@", altitude]];
    [self log:[NSString stringWithFormat:@"水平準度：%@", horizontalAccuracy]];
    [self log:[NSString stringWithFormat:@"垂直準度：%@", verticalAccuracy]];
    [self log:[NSString stringWithFormat:@"速度：%@", speed]];

    if (self.db != nil) {
        const char *sql = [[NSString stringWithFormat:@"INSERT INTO polylines ('lat', 'lng', 'altitude', 'horizontalAccuracy', 'verticalAccuracy', 'speed') VALUES ('%@', '%@', '%@', '%@', '%@', '%@')", lat, lng, altitude, horizontalAccuracy, verticalAccuracy, speed] cStringUsingEncoding:NSASCIIStringEncoding];
        sqlite3_stmt *statement;
        sqlite3_prepare(self.db, sql, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
            [self log:[NSString stringWithFormat:@"存入資料庫成功！"]];
        else
            [self log:[NSString stringWithFormat:@"存入資料庫失敗！"]];
        
        if (!self.isUpload) {
            const char *countSql = "SELECT COUNT(id) FROM polylines";
            sqlite3_prepare(self.db, countSql, -1, &statement, NULL);
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                char *count = (char *)sqlite3_column_text(statement, 0);
                if ([[NSString stringWithCString:count encoding:NSUTF8StringEncoding] integerValue] > 20) {
                    [self updateAll];
                    break;
                }
            }
        }
        
        sqlite3_finalize(statement);
    }
}
- (void)updateAll {
    if (self.isUpload)
        return;

    [self logDbLine];
    [self log:@"上傳路徑.."];

    if (!self.eventId) {
        [self log:@"沒有 Event ID"];
        return;
    }
    
    if (self.db != nil) {
        self.isUpload = YES;
        
        const char *sql = "SELECT * FROM polylines ORDER BY id ASC";
        sqlite3_stmt *statement;
        sqlite3_prepare(self.db, sql, -1, &statement, NULL);
        
        NSMutableDictionary *data = [NSMutableDictionary new];
        [data setValue:self.eventId forKey:@"event_id"];
        
        for (int i = 0; sqlite3_step(statement) == SQLITE_ROW; i++) {
            
            
            NSString *id = [NSString stringWithCString:(char *)sqlite3_column_text(statement, 0) encoding:NSUTF8StringEncoding];
            NSString *lat = [NSString stringWithCString:(char *)sqlite3_column_text(statement, 1) encoding:NSUTF8StringEncoding];
            NSString *lng = [NSString stringWithCString:(char *)sqlite3_column_text(statement, 2) encoding:NSUTF8StringEncoding];
            NSString *altitude = [NSString stringWithCString:(char *)sqlite3_column_text(statement, 3) encoding:NSUTF8StringEncoding];
            NSString *horizontalAccuracy = [NSString stringWithCString:(char *)sqlite3_column_text(statement, 4) encoding:NSUTF8StringEncoding];
            NSString *verticalAccuracy = [NSString stringWithCString:(char *)sqlite3_column_text(statement, 5) encoding:NSUTF8StringEncoding];
            NSString *speed = [NSString stringWithCString:(char *)sqlite3_column_text(statement, 6) encoding:NSUTF8StringEncoding];
            
            [data setValue:id forKey:[NSString stringWithFormat:@"polylines[%d][id]", i]];
            [data setValue:lat forKey:[NSString stringWithFormat:@"polylines[%d][lat]", i]];
            [data setValue:lng forKey:[NSString stringWithFormat:@"polylines[%d][lng]", i]];
            [data setValue:altitude forKey:[NSString stringWithFormat:@"polylines[%d][altitude]", i]];
            [data setValue:horizontalAccuracy forKey:[NSString stringWithFormat:@"polylines[%d][accuracy_h]", i]];
            [data setValue:verticalAccuracy forKey:[NSString stringWithFormat:@"polylines[%d][accuracy_v]", i]];
            [data setValue:speed forKey:[NSString stringWithFormat:@"polylines[%d][speed]", i]];
        }

        
        AFHTTPRequestOperationManager *httpManager = [AFHTTPRequestOperationManager manager];
        [httpManager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"application/json"]];
        [httpManager POST:[NSString stringWithFormat:@"http://maps.ioa.tw/api/ios/update_polylines"]
               parameters:data
                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                      
                      if ([[responseObject objectForKey:@"status"] boolValue]) {
                          [self log:@"上傳 update_polylines API 回傳成功"];
                          
                          const char *sql = [[NSString stringWithFormat:@"DELETE FROM polylines WHERE id IN (%@);", [[responseObject objectForKey:@"ids"] componentsJoinedByString:@", "]] cStringUsingEncoding:NSASCIIStringEncoding];
                          sqlite3_stmt *statement;
                          sqlite3_prepare(self.db, sql, -1, &statement, NULL);
                          
                          if (sqlite3_step(statement) == SQLITE_DONE)
                              [self log:[NSString stringWithFormat:@"資料庫設定成功！"]];
                          else
                              [self log:[NSString stringWithFormat:@"資料庫設定失敗！"]];
                          
                      } else {
                          [self log:@"上傳 update_polylines API 回傳失敗!"];
                      }
                      self.isUpload = NO;
                  }
                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                      self.isUpload = NO;
                      [self log:@"呼叫 update_polylines API 失敗!"];
                  }
         ];
        

        sqlite3_finalize(statement);
    }
}
- (void)stopGPS {
    [self.locationManager stopUpdatingLocation];
    [self.switchButton setOn:NO animated:YES];
    [self.switchLabel setText:@"關閉"];

    [self logLine];
    [self log:@"關閉 GPS 紀錄"];
}
- (void)startGPS {
    [self logLine];
    [self log:@"開啟 GPS 中.."];
    
    if (!self.eventId || ([self.eventId integerValue] < 1)) {
        [self log: @"沒有 Event ID"];
        [self log: @"初始化 Event ID"];
        [self initEventId:^(id eventId) {
            self.eventId = eventId;
            [self log:[NSString stringWithFormat:@"取得 Event ID 成功！\n  Event ID：%@", self.eventId]];
            [self cleanDbAction:nil];

            [self startGPS];
        } failure:^(NSString *msg) {
            [self log:msg];
            [self stopGPS];
        }];
    } else {
        [self.locationManager startUpdatingLocation];
        [self.switchButton setOn:YES animated:YES];
        [self.switchLabel setText:@"開啟"];
        [self log: @"有 Event ID"];
        [self log: @"開啟 GPS 紀錄"];
    }
}

- (IBAction)steperChangeAction:(UIStepper *)sender {
    [self.locationManager setDistanceFilter:sender.value];
    [self.steperLabel setText:[NSString stringWithFormat:@"%d", (int)sender.value]];
    
    [self logLine];
    [self log:[NSString stringWithFormat:@"距離：%d", (int)sender.value]];
}
- (IBAction)switchChangeAction:(UISwitch *)sender {
    if ([sender isOn])
        [self startGPS];
    else
        [self stopGPS];
}
- (IBAction)setEventIdAction:(id)sender {
    [self stopGPS];

    [self initEventId:^(id eventId) {
        self.eventId = eventId;
        [self log:[NSString stringWithFormat:@"取得 Event ID 成功！\n  Event ID：%@", self.eventId]];
        [self cleanDbAction:nil];
    } failure:^(NSString *msg) {
        self.eventId = nil;
        [self log:msg];
    }];
}
- (IBAction)cleanDbAction:(id)sender {
    [self logLine];
    [self log:@"清空資料庫中.."];
    
    if (self.db != nil) {
        const char *sql = [[NSString stringWithFormat:@"DELETE FROM polylines;"] cStringUsingEncoding:NSASCIIStringEncoding];
        sqlite3_stmt *statement;
        sqlite3_prepare(self.db, sql, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
            [self log:[NSString stringWithFormat:@"清除資料庫成功！"]];
        else
            [self log:[NSString stringWithFormat:@"清除資料庫失敗！"]];
        
        sqlite3_finalize(statement);
    }
}

@end

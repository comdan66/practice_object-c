//
//  ViewController.h
//  GPS2
//
//  Created by OA Wu on 2015/8/2.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "OAHUD.h"
#import "AFHTTPRequestOperationManager.h"
#import "AppDelegate.h"

@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *switchLabel;
@property (weak, nonatomic) IBOutlet UILabel *steperLabel;
@property (weak, nonatomic) IBOutlet UITextView *logTextView;
@property (weak, nonatomic) IBOutlet UISwitch *switchButton;

@property id eventId;
@property CLLocationManager *locationManager;
@property sqlite3 *db;
@property BOOL isUpload;

@end


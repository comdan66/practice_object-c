//
//  ViewController.h
//  MyLocationDemo
//
//  Created by OA Wu on 2015/6/10.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *latTextField;
@property (weak, nonatomic) IBOutlet UITextField *lngTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
- (IBAction)getLocationButton:(id)sender;


@end


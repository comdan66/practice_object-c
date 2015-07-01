//
//  MapViewController.h
//  OA_2.1
//
//  Created by OA Wu on 2015/7/1.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "REMarkerClusterer.h"
#import "AFHTTPRequestOperationManager.h"
#import "MarkerView.h"
#import "Config.h"


@interface MapViewController : UIViewController <MKMapViewDelegate, REMarkerClusterDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, readonly, nonatomic) REMarkerClusterer *clusterer;

@property BOOL isLoadPicture;
@property CLLocationCoordinate2D center;

@end

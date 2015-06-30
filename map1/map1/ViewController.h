//
//  ViewController.h
//  map1
//
//  Created by OA Wu on 2015/6/29.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
//#import "MyAnno.h"
#import "REMarkerClusterer.h"
#import "AFHTTPRequestOperationManager.h"
//#import "MKAnnotationView+WebCache.h"
//#import "MyMKAnnotationView.h"

#import "AsyncImageView.h"

@interface ViewController : UIViewController <MKMapViewDelegate, REMarkerClusterDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, readonly, nonatomic) REMarkerClusterer *clusterer;


@end


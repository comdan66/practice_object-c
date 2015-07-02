//
//  MapViewController.m
//  OA_2.1
//
//  Created by OA Wu on 2015/7/1.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@property (strong, readwrite, nonatomic) REMarkerClusterer *clusterer;

@end

@implementation MapViewController

@synthesize isLoadPicture, center;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    isLoadPicture = NO;
    
    center = CLLocationCoordinate2DMake([[[USER_DEFAULTS objectForKey:@"location"] objectForKey:@"latitude"] doubleValue], [[[USER_DEFAULTS objectForKey:@"location"] objectForKey:@"longitude"] doubleValue]);

    [self.mapView setDelegate:self];
    [self.mapView setRotateEnabled:NO];
    [self.mapView setZoomEnabled:YES];
    [self.mapView setRegion:MKCoordinateRegionMake(center, MKCoordinateSpanMake(0.025, 0.025)) animated:YES];

    [self setClusterer:[[REMarkerClusterer alloc] initWithMapView:self.mapView delegate:self]];
    [self.clusterer setGridSize:65];
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    if (isLoadPicture)
        return;

    isLoadPicture = YES;
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc]init];
    [data setValue:[[NSString alloc] initWithFormat:@"%f", self.mapView.region.center.latitude] forKey:@"center[latitude]"];
    [data setValue:[[NSString alloc] initWithFormat:@"%f", self.mapView.region.center.longitude] forKey:@"center[longitude]"];
    [data setValue:[[NSString alloc] initWithFormat:@"%f", self.mapView.region.span.latitudeDelta] forKey:@"span[latitudeDelta]"];
    [data setValue:[[NSString alloc] initWithFormat:@"%f", self.mapView.region.span.longitudeDelta] forKey:@"span[longitudeDelta]"];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"application/json"]];
    [manager GET:[NSString stringWithFormat:@"http://ios.ioa.tw/api/v1/region_pictures"]
      parameters:data
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             if ([[responseObject objectForKey:@"status"] boolValue]) {
                 
                 NSMutableArray *newMarks = [NSMutableArray new];
                 
                 for (NSMutableDictionary *picture in [responseObject objectForKey:@"pictures"]) {
                     
                     REMarker *marker = [[REMarker alloc] init];
                     
                     marker.markerId = [[picture objectForKey:@"id"] integerValue];
                     marker.coordinate = CLLocationCoordinate2DMake([[picture objectForKey:@"lat"] doubleValue], [[picture objectForKey:@"lng"] doubleValue]);
                     marker.userInfo = picture;
                     [newMarks addObject:marker];
                 }
                 
                 BOOL has = NO;
                 NSMutableArray *removes = [NSMutableArray new];
                 for (REMarker *oriObj in self.clusterer.markers) {
                     has = NO;
                     for (REMarker *newOri in newMarks)
                         if (oriObj.markerId == newOri.markerId) {
                             has = YES;
                             break;
                         }
                     if (!has)
                         [removes addObject:oriObj];
                 }
                 
                 NSMutableArray *adds = [NSMutableArray new];
                 for (REMarker *newOri in newMarks) {
                     has = NO;
                     for (REMarker *oriObj in self.clusterer.markers) {
                         if (newOri.markerId == oriObj.markerId) {
                             has = YES;
                             break;
                         }
                     }
                     if (!has) {
                         [adds addObject:newOri];
                     }
                 }
                 [self.clusterer removeMarkers:removes];
                 [self.clusterer addMarkers:adds];

                 [self.mapView removeAnnotations:self.mapView.annotations];
                 [self.clusterer clusterize:NO];
                 
             }
             
             isLoadPicture = NO;
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             isLoadPicture = NO;
         }
     ];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(RECluster *)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    MKAnnotationView *annView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:[NSString stringWithFormat:@"MyAnno_%lu_%lu", ((REMarker *)[annotation.markers objectAtIndex:0]).markerId, annotation.markers.count]];
    
    if (annView == nil) {
        annView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:[NSString stringWithFormat:@"MyAnno_%lu_%lu", ((REMarker *)[annotation.markers objectAtIndex:0]).markerId, annotation.markers.count]];
        MarkerView *markerView;
        
        if (annotation.markers.count == 1)
            markerView = [MarkerView initSingle:annotation mapView:self.mapView];
        else
            markerView = [MarkerView initMulti:annotation mapView:self.mapView];
        
        [annView addSubview:markerView];
        
        [annView setFrame:CGRectMake(0, 0, 50, 50)];
        [annView setCenterOffset:CGPointMake(-25,-25)];
        [annView setCanShowCallout:NO];
        [annView setDraggable:NO];
    }
    
//    
//    MarkerView *markerView;
//
//    if (annotation.markers.count == 1)
//        markerView = [MarkerView initSingle:annotation mapView:self.mapView];
//    else
//        markerView = [MarkerView initMulti:annotation mapView:self.mapView];
//    
//    [annView addSubview:markerView];
//
//    [annView setFrame:CGRectMake(0, 0, 50, 50)];
//    [annView setCenterOffset:CGPointMake(-25,-25)];
//    [annView setCanShowCallout:NO];
//    [annView setDraggable:NO];
    
    return annView;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self mapView:self.mapView regionDidChangeAnimated:NO];
}
-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    [self.clusterer removeAllMarkers];
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.clusterer clusterize:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

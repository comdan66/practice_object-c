//
//  ViewController.m
//  map1
//
//  Created by OA Wu on 2015/6/29.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    CLLocationCoordinate2D center;
    BOOL isLoadPicture;
}
@property (strong, readwrite, nonatomic) REMarkerClusterer *clusterer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isLoadPicture = NO;
    center = CLLocationCoordinate2DMake(24.977953065589, 121.46128272033);
    
    [self.mapView setDelegate:self];
    [self.mapView setZoomEnabled:YES];
    [self.mapView setRegion:MKCoordinateRegionMake(center, MKCoordinateSpanMake(0.025, 0.025)) animated:YES];
    
    [self setClusterer:[[REMarkerClusterer alloc] initWithMapView:self.mapView delegate:self]];
    [self.clusterer setGridSize:65];//距離
    
    [self.clusterer clusterize:NO];
    [self.clusterer zoomToAnnotationsBounds:self.clusterer.markers];
    
//
//    REMarker *marker = [[REMarker alloc] init];
//
//    marker.markerId = 1;
//    marker.coordinate = CLLocationCoordinate2DMake(25.029125883589, 121.59658010933);
//    [self.clusterer addMarker:marker];
//    
//    marker = [[REMarker alloc] init];
//    
//    marker.markerId = 2;
//    marker.coordinate = CLLocationCoordinate2DMake(25.129125883589, 121.29658010933);
//    [self.clusterer addMarker:marker];
//
//
    
    
//    [self.mapView s]
    
//        MKPointAnnotation *point;
//        point = [MKPointAnnotation new];
//        [point setCoordinate:CLLocationCoordinate2DMake(25.029125883589, 121.59658010933)];
//        [self.mapView addAnnotation:point];
    
//    MyAnno *anno;
    
//    anno = [[MyAnno alloc] initWithLocation:CLLocationCoordinate2DMake(25.029125883589, 121.59658010933)];
////    [anno setTitle:@"dasdasdasda"];
////    [anno setSubtitle:@"dasdasdasdas"];
//    [anno setImg:[UIImage imageNamed:@"marker"]];
//    [self.mapView addAnnotation:anno];
    
    
    // Do any additional setup after loading the view, typically from a nib.
//    
//    MKPointAnnotation *point;
//    
//    point = [MKPointAnnotation new];
//    [point setCoordinate:center];
//    [self.mapView addAnnotation:point];
//    
//    point = [MKPointAnnotation new];
//    [point setCoordinate:CLLocationCoordinate2DMake(25.083820471589 + 0.002138 / 2  , 121.59658010933)];
//    [self.mapView addAnnotation:point];
    
    
    
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
                      marker.userInfo = [picture objectForKey:@"url"];
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
    
    static NSString *pinID;
    static NSString *clusterPinID = @"REClusterPin";
    static NSString *markerPinID = @"REMarkerPin";
    
    pinID = annotation.markers.count == 1 ? markerPinID : clusterPinID;
    
//    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:pinID];
    MyMKAnnotationView *annView = (MyMKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomAnnotation"];
    
    if (annView == nil) {
        annView = [[MyMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomAnnocation"];
        

    }
    [annView sd_setImageWithURL:[NSURL URLWithString:[((REMarker *)[annotation.markers objectAtIndex:0]).userInfo objectForKey:@"w100"]]]; 
//    [annView inita];
//    annView.image = [UIImage imageNamed:@"Pin_Red"];
    
    return annView;
}
- (void) handlePinButtonTap:(UITapGestureRecognizer *)gestureRecognizer
{
    UIButton *btn = (UIButton *) gestureRecognizer.view;
    MKAnnotationView *av = (MKAnnotationView *)[btn superview];
    id<MKAnnotation> ann = av.annotation;
    NSLog(@"handlePinButtonTap: ann.title=%@", ann.title);
}

//
//- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
////    mapRegion = self.mapView.region;
////    NSLog(@"%@", self.mapView.region);
//    NSLog(@"xxx");
////}
//-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
////    MKCoordinateRegion newRegion = self.mapView.region;
////    NSInteger zFactor;
////self.mapView.region.center.longitude
////    
////    NSLog(@"===============%f", self.mapView.region.span.longitudeDelta);
//
////    if ((self.mapView.region.span.latitudeDelta / newRegion.span.latitudeDelta) > 1.5){
////
////        NSLog(@"Zoom in changed");
////        zFactor = 20;
//////        CustomPlacemark *aO;
//////        MKAnnotationView *aV;
//////        for (aO in self.mapView.annotations) {
//////            aV = [[self mapView] viewForAnnotation:aO];
//////            aV.frame = CGRectMake(aV.frame.origin.x, aV.frame.origin.y, aV.frame.size.width+zFactor, aV.frame.size.height+zFactor);
//////            [[[self mapView] viewForAnnotation:aO] setFrame:aV.frame];
//////        }
////    }
////    if ((self.mapView.region.span.latitudeDelta / newRegion.span.latitudeDelta) < 0.75){
////        NSLog(@"Zoom out");
////        zFactor = -20;
//////        CustomPlacemark *aO;
//////        MKAnnotationView *aV;
//////        for (aO in self.mapView.annotations) {
//////            aV = [[self mapView] viewForAnnotation:aO];
//////            aV.frame = CGRectMake(aV.frame.origin.x, aV.frame.origin.y, aV.frame.size.width+zFactor, aV.frame.size.height+zFactor);
//////            [[[self mapView] viewForAnnotation:aO] setFrame:aV.frame];
//////        }
////    }
//    
//}







//- (void)segmentedControlChanged:(UISegmentedControl *)segmentedControl
//{
////    [self.mapView removeAnnotations:self.mapView.annotations];
////    [self.clusterer clusterize:NO];
//}
- (IBAction)TEST:(id)sender {
    [self.mapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(25.029125883589, 121.59658010933), MKCoordinateSpanMake(5, 5)) animated:YES];
}

//-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
//{
////    // 判斷這個annotation是不是屬於顯示目前所在位置的那一個註解
////    if ([annotation isKindOfClass:[MKUserLocation class]]) {
////        return nil;
////    }
////
////    MKAnnotationView *annView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomAnnotation"];
////
////    if (annView == nil) {
////        annView = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"CustomAnnocation"];
////    }
////    
////    annView.image = ((MyAnno *)annotation).img;
////    
////    return annView;
//}

- (void)viewDidAppear:(BOOL)animated {
    self.mapView.centerCoordinate = center;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

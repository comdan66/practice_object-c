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

//- (void) handlePinButtonTap:(UITapGestureRecognizer *)gestureRecognizer
//{
//    [self.clusterer zoomToAnnotationsBounds:self.clusterer.markers];
////    NSLog(@"handlePinButtonTap: ann.title=%lu", );
////    self.annotation.zoomToAnnotationsBounds
//}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(RECluster *)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    
    MKAnnotationView *annView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomAnnotation"];
    
    if (annView == nil) {
        annView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"CustomAnnocation"];
    }
    
    MarkerView *markerView;
    if (annotation.markers.count == 1) {
        markerView = [MarkerView initSingle:annotation mapView:self.mapView];
    } else {
        markerView = [MarkerView initMulti:annotation mapView:self.mapView];
    }

    [annView addSubview:markerView];
    [annView setFrame:CGRectMake(0, 0, 50, 50)];
    annView.centerOffset = CGPointMake(-25,-25);
    
    annView.canShowCallout = NO;
    annView.draggable = NO;
    
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
//                                          initWithTarget:self action:@selector(handlePinButtonTap:)];
//    tapGesture.numberOfTapsRequired = 1;
//    [annView addGestureRecognizer:tapGesture];
    
    return annView;
    
    
//    
//    AsyncImageView *imageView = [[AsyncImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    
//
//    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:imageView];
//    [imageView setImageURL:[NSURL URLWithString:[((REMarker *)[annotation.markers objectAtIndex:0]).userInfo objectForKey:@"w100"]]];
//    
////    [imageView.layer setCornerRadius:30];
//    [imageView.layer setBorderColor:[UIColor redColor].CGColor];
//    [imageView.layer setBorderWidth:10.0f / [UIScreen mainScreen].scale];
////    [imageView setClipsToBounds:YES];
//    [imageView setContentMode:UIViewContentModeScaleAspectFill];
//    
//    [imageView.layer setShadowColor:[UIColor colorWithRed:0.15 green:0.16 blue:0.13 alpha:1].CGColor];
//    [imageView.layer setShadowOffset:CGSizeMake(2.4f, 2.0f)];
//    [imageView.layer setShadowRadius:5.0f];
//    [imageView.layer setShadowOpacity:0.5f];
    
//    MarkerView *markerView = [[MarkerView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//    [markerView setBackgroundColor:[UIColor colorWithRed:0.84 green:0.84 blue:0.84 alpha:1]];
    
    
//    MarkerView *markerView = (MarkerView *)[tableView dequeueReusableCellWithIdentifier:@"IndexTableViewCell"];
//    if(!cell){
//        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"IndexTableViewCell" owner:self options:nil];
//        cell = [nibs objectAtIndex:0];
//    }
    
//    [annView sd_setImageWithURL:[NSURL URLWithString:[((REMarker *)[annotation.markers objectAtIndex:0]).userInfo objectForKey:@"w100"]]];
//    [annView inita];
//    annView.image = [UIImage imageNamed:@"Pin_Red"];
    
    
    
    
    
    
    
    
    
    
    
//    MKAnnotationView *annView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];

//    
//    //change here
//    annView.image = [UIImage imageNamed:[NSString stringWithFormat:@"Pin_Purple"]];
//    
//    UIImage *frame = [UIImage imageNamed:[NSString stringWithFormat:@"Pin_Purple"]];
//  UIImage *image = [UIImage imageNamed:@"Pin_Red"];
//  
//  UIGraphicsBeginImageContext(CGSizeMake(200, 200));
//  
//  [frame drawInRect:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//  [image drawInRect:CGRectMake(2, 2, 60, 60)]; // the frame your inner image
//  //maybe you should draw the left bottom icon here,
//  
//  
//  //then set back the new image, done
//  annView.image = UIGraphicsGetImageFromCurrentImageContext();
//  
//  UIGraphicsEndImageContext();
//  
//  
//  
//  
//  
//  UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
////  [rightButton addTarget:self action:@selector(writeSomething:) forControlEvents:UIControlEventTouchUpInside];
//  [rightButton setTitle:annotation.title forState:UIControlStateNormal];
//  
//  annView.rightCalloutAccessoryView = rightButton;
  
  
  
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

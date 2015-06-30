//
//  ViewController.m
//  map1
//
//  Created by OA Wu on 2015/6/29.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.delegate = self;
    
    MyAnno *anno;
    
    anno = [[MyAnno alloc] initWithLocation:CLLocationCoordinate2DMake(25.029125883589, 121.59658010933)];
//    [anno setTitle:@"dasdasdasda"];
//    [anno setSubtitle:@"dasdasdasdas"];
    [anno setImg:[UIImage imageNamed:@"marker"]];
    [self.mapView addAnnotation:anno];
    
    
    // Do any additional setup after loading the view, typically from a nib.
//    
//    MKPointAnnotation *point;
//
//    point = [MKPointAnnotation new];
//    [point setCoordinate:CLLocationCoordinate2DMake(25.029125883589, 121.59658010933)];
////    [point setTitle:@"dasdasdasda"];
////    [point setSubtitle:@"dasdasdasdas"];
//    [self.mapView addAnnotation:point];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    // 判斷這個annotation是不是屬於顯示目前所在位置的那一個註解
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }

    MKAnnotationView *annView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"CustomAnnotation"];

    if (annView == nil) {
        annView = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"CustomAnnocation"];
    }
    
    annView.image = ((MyAnno *)annotation).img;
    
    return annView;
}

- (void)viewDidAppear:(BOOL)animated {
    self.mapView.centerCoordinate = CLLocationCoordinate2DMake(25.029125883589, 121.59658010933);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

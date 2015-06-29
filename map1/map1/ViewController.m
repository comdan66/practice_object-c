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
    // Do any additional setup after loading the view, typically from a nib.
    
    MKPointAnnotation *point;

    point = [MKPointAnnotation new];
    [point setCoordinate:CLLocationCoordinate2DMake(25.029125883589, 121.59658010933)];
//    [point setTitle:@"dasdasdasda"];
//    [point setSubtitle:@"dasdasdasdas"];
    [self.mapView addAnnotation:point];
}

- (void)viewDidAppear:(BOOL)animated {
    self.mapView.centerCoordinate = CLLocationCoordinate2DMake(25.029125883589, 121.59658010933);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  MyAnno.h
//  map1
//
//  Created by OA Wu on 2015/6/29.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnno : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic) UIImage *img;

- (id) initWithLocation:(CLLocationCoordinate2D) coord;

@end

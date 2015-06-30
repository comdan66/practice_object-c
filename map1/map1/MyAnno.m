//
//  MyAnno.m
//  map1
//
//  Created by OA Wu on 2015/6/29.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "MyAnno.h"


@implementation MyAnno

@synthesize coordinate, img;

- (id) initWithLocation:(CLLocationCoordinate2D) coord {
    self = [super init];
    
    if (self) {
        coordinate = coord;
    }
    
    return self;
}

@end

//
//  Markers.h
//  gps
//
//  Created by OA Wu on 2015/7/31.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Markers : NSManagedObject

@property (nonatomic, retain) NSString * lat;
@property (nonatomic, retain) NSString * lng;
@property (nonatomic, retain) NSString * altitude;
@property (nonatomic, retain) NSString * horizontalAccuracy;
@property (nonatomic, retain) NSString * verticalAccuracy;
@property (nonatomic, retain) NSString * speed;
@property (nonatomic, retain) NSNumber * id;

@end

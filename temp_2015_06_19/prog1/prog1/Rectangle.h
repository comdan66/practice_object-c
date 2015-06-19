//
//  Rectangle.h
//  prog1
//
//  Created by OA Wu on 2015/5/2.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XYPoint.h";
@interface Rectangle : NSObject


@property int width, height;
@property XYPoint* origin;

-(void) setWidth: (int)w andHeight: (int)h;
-(int) area;
-(int) perimeter;
-(void) setOrigin2: (XYPoint *) p;


@end

//
//  Rectangle.m
//  prog1
//
//  Created by OA Wu on 2015/5/2.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "Rectangle.h"


@implementation Rectangle {
    XYPoint* origin;
}

@synthesize width, height;

-(void) setWidth: (int)w andHeight: (int)h {
    width = w;
    height = h;
}

-(void) setOrigin: (XYPoint *)pt {
    origin = pt;
}

-(int) area {
    return width * height;
}

-(int) perimeter {
    return (width + height) * 2;
}

-(XYPoint *) origin {
    return origin;
}

@end

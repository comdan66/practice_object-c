//
//  Rectangle.h
//  prog1
//
//  Created by OA Wu on 2015/5/2.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Rectangle : NSObject


@property int width, height;

-(void) setWidth: (int)w andHeight: (int)h;
-(int) area;
-(int) perimeter;


@end

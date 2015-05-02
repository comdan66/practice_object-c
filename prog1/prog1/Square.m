//
//  Square.m
//  prog1
//
//  Created by OA Wu on 2015/5/2.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "Square.h"

@implementation Square

-(void) setSide:(int)s {
    [self setWidth: s andHeight: s];
}

-(int) side {
    return self.width;
}

@end

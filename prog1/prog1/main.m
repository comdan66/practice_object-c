//
//  main.m
//  prog1
//
//  Created by OA Wu on 2015/4/27.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "Rectangle.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Rectangle* myRect = [Rectangle new];
        [myRect setWidth:5 andHeight: 8];
        
        NSLog(@"Rectagle: w = %i, h = %i", myRect.width, myRect.height);
        NSLog(@"Area = %i, perimeter = %i", myRect.area, myRect.perimeter);
    }
    return 0;
}

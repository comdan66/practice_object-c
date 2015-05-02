//
//  main.m
//  prog1
//
//  Created by OA Wu on 2015/4/27.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "Rectangle.h"
#import "XYPoint.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Rectangle* myRect = [Rectangle new];
        XYPoint* myPoint = [XYPoint new];

        [myPoint setX: 100 andY: 200];
        [myRect setWidth: 5 andHeight: 8];
        
        myRect.origin = myPoint;
        
        NSLog(@"W = %i, H = %i", myRect.width, myRect.height);
        
        NSLog(@"X = %i, Y = %i", myPoint.x, myPoint.y);
        
        NSLog(@"Area = %i, Perimeter = %i", myRect.area, myRect.perimeter);
        
        
        
        
//        Square* mySquare = [Square new];
//        
//        [mySquare setSide: 10];
//        NSLog(@"Rectagle: w = %i, h = %i", [mySquare side], [mySquare side]);
//        NSLog(@"Area = %i, perimeter = %i", [mySquare area], [mySquare perimeter]);
        
//        Rectangle* myRect = [Rectangle new];
//        [myRect setWidth:5 andHeight: 8];
//        
//        NSLog(@"Rectagle: w = %i, h = %i", myRect.width, myRect.height);
//        NSLog(@"Area = %i, perimeter = %i", myRect.area, myRect.perimeter);
    }
    return 0;
}

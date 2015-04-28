//
//  Fraction.h
//  prog1
//
//  Created by OA Wu on 2015/4/28.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fraction : NSObject

@property int numerator, denominator;

-(void) print;
-(double) covertToNum;

@end

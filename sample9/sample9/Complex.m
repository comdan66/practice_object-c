//
//  Complex.m
//  sample9
//
//  Created by OA Wu on 2015/5/4.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "Complex.h"

@implementation Complex

@synthesize real, imaginary;

-(void) print {
    NSLog(@"%g + %gi ", real, imaginary);
}
-(void) setReal: (double) a andImaginary: (double) b {
    real = a;
    imaginary = b;
}
-(Complex *) add: (Complex *) f {
    Complex *result = [Complex new];
    
    result.real = real + f.real;
    result.imaginary = imaginary + f.imaginary;
    
    return result;
}
@end

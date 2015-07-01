//
//  MarkerView.h
//  map1
//
//  Created by OA Wu on 2015/7/1.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncImageView.h"

@interface MarkerView : UIView
@property (weak, nonatomic) IBOutlet AsyncImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property NSString *nibType;

+ (MarkerView *)initSingle;
+ (MarkerView *)initMulti;

- (void)initUI:(NSURL *) url;
@end

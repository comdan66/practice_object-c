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

+ (id)customView;


- (void)initUI:(NSURL *) url;
@end

//
//  backDelegate.h
//  OA_1.5
//
//  Created by OA Wu on 2015/6/16.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#ifndef OA_1_5_backDelegate_h
#define OA_1_5_backDelegate_h


@protocol BackDelegate <NSObject>

- (void)updateEvent:(NSString *) id title:(NSString *)title;
@end

#endif

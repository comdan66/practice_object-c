//
//  MyViewController.h
//  PassArguments
//
//  Created by OA Wu on 2015/6/11.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyViewController : UIViewController {
    NSString *userInputData;
}
@property (weak, nonatomic) IBOutlet UILabel *label;

-(void)passData:(NSString *) str;

@end

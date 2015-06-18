//
//  ViewController.h
//  Cam
//
//  Created by OA Wu on 2015/6/17.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "MyHttp.h"

@interface ViewController : UIViewController<UINavigationControllerDelegate,
UIImagePickerControllerDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *image;

@end


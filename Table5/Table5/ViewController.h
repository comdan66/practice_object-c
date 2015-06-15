//
//  ViewController.h
//  Table5
//
//  Created by OA Wu on 2015/6/15.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "MyCell.h"

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate> {
    ALAssetsLibrary *lib;
    NSMutableArray *imgs;
}
@property (weak, nonatomic) IBOutlet UICollectionView *colView;


@end


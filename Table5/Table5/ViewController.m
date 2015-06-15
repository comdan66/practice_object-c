//
//  ViewController.m
//  Table5
//
//  Created by OA Wu on 2015/6/15.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    lib = [ALAssetsLibrary new];
    [lib enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        NSMutableArray *temp = [NSMutableArray new];
        
        if (group != nil) {
            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if (result != nil) {
                    [temp addObject:result];
                }
            }];
            
            imgs = [temp copy];
            [self.colView reloadData];
        }
    } failureBlock:^(NSError *error) {
    
    }];
}
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [imgs count];
}
-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MyCell *cell = (MyCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [MyCell new];
    }
    
    CGImageRef img = [[imgs objectAtIndex:indexPath.row] thumbnail];
    cell.image.image = [UIImage imageWithCGImage:img];

    return cell;
}
@end

//
//  ViewController.m
//  MyTable
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
    list = [NSMutableArray new];
    
    [list addObject:[NSArray arrayWithObjects:@"A", @"aa", nil]];
    [list addObject:[NSArray arrayWithObjects:@"B", @"bb", nil]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [list count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *indicator = @"Cell";
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:indicator];
    
    if (cell == nil) {
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:nil options:nil];
        
        for (UIView *view in views) {
            if ([view isKindOfClass:[CustomCell class]]) {
                cell = (CustomCell *)view;
                break;
            }
        }
    }
    
    cell.leftLabel.text = [[list objectAtIndex:indexPath.row] objectAtIndex:0];
    cell.rightLabel.text = [[list objectAtIndex:indexPath.row] objectAtIndex:1];
    
    return cell;
}

@end

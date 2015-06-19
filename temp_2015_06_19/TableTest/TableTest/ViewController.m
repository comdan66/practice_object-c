//
//  ViewController.m
//  TableTest
//
//  Created by OA Wu on 2015/6/14.
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
    [list addObject:@"AAA"];
    [list addObject:@"BBB"];
    [list addObject:@"CCC"];
    [list addObject:@"DDD"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [list count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"Cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    switch (indexPath.row) {
        case 0:
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
        case 1:
            cell.accessoryType = UITableViewCellAccessoryDetailButton;
            break;
        case 2:
            cell.accessoryType = UITableViewCellAccessoryDetailButton;
            break;
        case 3:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
            
        default:
            break;
    }
    cell.textLabel.text = [list objectAtIndex:indexPath.row];
    return cell;
    
}

@end

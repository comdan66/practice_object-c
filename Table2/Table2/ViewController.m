//
//  ViewController.m
//  Table2
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
    list2 = [NSMutableArray new];
    
    [list addObject:@"aaa"];
    [list addObject:@"bbb"];
    [list addObject:@"ccc"];
    [list addObject:@"ddd"];
    
    [list2 addObject:@"111"];
    [list2 addObject:@"222"];
    [list2 addObject:@"333"];
    [list2 addObject:@"444"];
    
//    self.toolBar
    
    
    
    
//    NSLayoutConstraint *headlineTop = [NSLayoutConstraint constraintWithItem:self.toolBar
//                                                                   attribute:NSLayoutAttributeTop
//                                                                   relatedBy:NSLayoutRelationEqual
//                                                                      toItem:self.view
//                                                                   attribute:NSLayoutAttributeTop
//                                                                  multiplier:1.0
//                                                                    constant:60];
//    [self.view addConstraint:headlineTop];
//
//    
//    NSLayoutConstraint *headlineLeft = [NSLayoutConstraint constraintWithItem:self.toolBar
//                                                                    attribute:NSLayoutAttributeLeading
//                                                                    relatedBy:NSLayoutRelationEqual
//                                                                       toItem:self.view
//                                                                    attribute:NSLayoutAttributeLeft
//                                                                   multiplier:1.0
//                                                                     constant:20];
//    [self.view addConstraint:headlineLeft];
//    
//    NSLayoutConstraint *headlineRight = [NSLayoutConstraint constraintWithItem:self.toolBar
//                                                                     attribute:NSLayoutAttributeTrailing
//                                                                     relatedBy:NSLayoutRelationEqual
//                                                                        toItem:self.view
//                                                                     attribute:NSLayoutAttributeRight
//                                                                    multiplier:1.0
//                                                                      constant:-20];
//    [self.view addConstraint:headlineRight];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return [list count];
//}
//-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *indicator = @"Cell";
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indicator];
//    
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indicator];
//    }
//    cell.textLabel.text = [list objectAtIndex:indexPath.row];
//    
//    return cell;
//}






- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger n;
    
    switch (section) {
        case 0:
            n = [list count];
            break;
        default:
            n = [list2 count];
            break;
    }
    return n;
}
- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *header;
    
    switch (section) {
        case 0:
            header = @"英文";
            break;
            
        case 1:
            header = @"數字";
            break;
    }
    
    return header;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *indicator = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indicator];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indicator];
    }
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = [list objectAtIndex:indexPath.row];
            break;
            
        case 1:
            cell.textLabel.text = [list2 objectAtIndex:indexPath.row];
            break;
    }
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    return cell;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    
    switch (indexPath.section) {
        case 0:
            [list removeObjectAtIndex:indexPath.row];
            break;
            
        case 1:
            [list2 removeObjectAtIndex:indexPath.row];
            break;
    }
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
}
- (IBAction)insertData:(id)sender {
    static int i;
    
    [list addObject:[NSString stringWithFormat:@"%d", i++]];
    [self.tableView reloadData];
}
- (IBAction)editList:(UIBarButtonItem *)sender {
    if (self.tableView.isEditing) {
        sender.title = @"編輯";
    } else {
        sender.title = @"完成";
    }
    self.tableView.editing = !self.tableView.editing;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%li  -  %@", indexPath.section, [list objectAtIndex:indexPath.row]);
}
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {

    [list exchangeObjectAtIndex: sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
}
@end

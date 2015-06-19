//
//  MyTableViewController.m
//  OA_1.2
//
//  Created by OA Wu on 2015/6/16.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "MyTableViewController.h"

@interface MyTableViewController () {
    NSMutableDictionary *events;
    NSString *next_id;
}

@end

@implementation MyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    events = [NSMutableDictionary new];
    next_id = [[NSString alloc] initWithFormat:@"0"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(handleRefresh) forControlEvents:UIControlEventValueChanged];
}


-(void)viewDidAppear:(BOOL)animated {
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"更新.."];
}
-(void)handleRefresh {
//    NSMutableDictionary *vars = [NSMutableDictionary new];
//    [vars setObject:@"oa" forKey:@"account"];
//    [vars setObject:@"123" forKey:@"password"];
//    OaHttp *http = [OaHttp new];
//
//    [http postURL:@"http://ios.ioa.tw/api/login" vars:vars completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"%@",str);
//    }];
//    NSMutableDictionary *vars = [NSMutableDictionary new];
//    [vars setObject:@"0" forKey:@"next_id"];
//    [http getURL:@"http://ios.ioa.tw/api/events" vars: vars completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//                NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                NSLog(@"%@",str);
//            }];
    
    MyHttp *http = [MyHttp new];
    NSMutableDictionary *vars = [NSMutableDictionary new];
    [vars setObject:next_id forKey:@"next_id"];
    
    [http getURL:@"http://ios.ioa.tw/api/events" vars: vars completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        if ([[result objectForKey:@"status"] boolValue]) {
            for (NSMutableDictionary *event in [result objectForKey:@"events"]) {
                [events setObject:[event objectForKey:@"title"] forKey:[event objectForKey:@"id"]];
            }
            next_id = [result objectForKey:@"next_id"];
        }
        
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [events count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = [events objectForKey:[[events allKeys] objectAtIndex:indexPath.row]];
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

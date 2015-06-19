//
//  MyTableViewController.m
//  Table7
//
//  Created by OA Wu on 2015/6/18.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "MyTableViewController.h"

@interface MyTableViewController () {
    NSMutableArray *list;
}

@end

@implementation MyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    list = [NSMutableArray new];
    [list addObject:@"aaaaa"];
    [list addObject:@"bbbbb"];
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
//    NSLog(@"a");
//    return cell.frame.size.height;

    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [list count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
//    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell"];

//    [cell.contentView.layer setBorderColor:[UIColor redColor].CGColor];
//    [cell.contentView.layer setBorderWidth:1.0f];
    
    cell.xxxxx.text = [list objectAtIndex:indexPath.row];
//    NSLog(@"%f", cell.bounds.size.height);
//    NSLog(@"b");
    //    NSLog(@"%f", cell.frame.size.width);

//    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:cell.pictureImageView];
//    [cell.pictureImageView setImageURL:[NSURL URLWithString:@"http://ios.ioa.tw/upload/pictures/name/0/0/0/10/800w_1114559844_5581a714b574a.jpg"]];
//    [NSURL URLWithString:@"http://ios.ioa.tw/upload/pictures/name/0/0/0/10/800w_1114559844_5581a714b574a.jpg"];
//    cell.xxxxx = @"xxxxx";
    NSLog(@"%@", cell);
    
//    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:cell.pictureImageView];
//    NSLog(@"%@", );
//    [cell setFrame:CGRectMake(0, 0, cell.frame.size.width, 100)];
//    cell.xxx.text = @"ddas";
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

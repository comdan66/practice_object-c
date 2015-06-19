//
//  MyTableViewController.m
//  Table8
//
//  Created by OA Wu on 2015/6/18.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "MyTableViewController.h"

@interface MyTableViewController () <UIScrollViewDelegate>{
    NSMutableArray *pictures;
    NSString *nextId;
    BOOL isLoading;
}

@end

@implementation MyTableViewController

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (isLoading)
        return;

    if ((scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height * 2)) {
        [self loadData:nil];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    isLoading = NO;
    pictures = [NSMutableArray new];
    
    UIAlertView *loadingAlertView = [[UIAlertView alloc] initWithTitle:@"Loading..." message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [loadingAlertView show];
    
    [self loadData:loadingAlertView];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)loadData:(UIAlertView *) alert{

    isLoading = YES;

    MyHttp *http = [MyHttp new];
    NSMutableDictionary *vars = [NSMutableDictionary new];
    [vars setObject:nextId == nil ? @"0" : nextId forKey:@"next_id"];
    
    [http getURL:@"http://ios.ioa.tw/api/next_pictures" vars: vars completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

        if ([[result objectForKey:@"status"] boolValue]) {
            for (NSMutableDictionary *picture in [result objectForKey:@"pictures"]) {
                [pictures addObject: picture];
            }
            nextId = [[NSString alloc] initWithFormat:@"%@", [result objectForKey:@"next_id"]];
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];

            if (alert != nil)
                [alert dismissWithClickedButtonIndex:-1 animated:YES];

            isLoading = NO;
        });
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}
//
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.

    return [pictures count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
//        return cell.frame.size.height;
    
//    MyTableViewCell *cell = (MyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MyTableViewCell"];
//    if(!cell){
//        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"MyTableViewCell" owner:self options:nil];
//        cell = [nibs objectAtIndex:0];
//    }
//
    double gradient = [[[pictures objectAtIndex:indexPath.row] objectForKey:@"gradient"] floatValue];
//
    return (self.tableView.frame.size.width + 32) * gradient + 100;
    

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MyTableViewCell *cell = (MyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MyTableViewCell"];
    if(!cell){
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"MyTableViewCell" owner:self options:nil];
        cell = [nibs objectAtIndex:0];
    }
    cell.pictureImageView.contentMode = UIViewContentModeScaleToFill;

    [cell.contentView.layer setBorderColor:[UIColor redColor].CGColor];
    [cell.contentView.layer setBorderWidth:1.0f];
    
    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:cell.pictureImageView];
    [cell.pictureImageView setImageURL:[NSURL URLWithString:[[pictures objectAtIndex:indexPath.row] objectForKey:@"url"]]];
    
    cell.titleLabel.text = [[pictures objectAtIndex:indexPath.row] objectForKey:@"title"];
    
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

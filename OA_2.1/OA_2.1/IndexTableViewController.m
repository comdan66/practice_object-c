//
//  IndexTableViewController.m
//  OA_2.1
//
//  Created by OA Wu on 2015/6/25.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "IndexTableViewController.h"

@interface IndexTableViewController () {
    NSMutableArray *pictures;
    NSString *nextId;
    float titleLabelOneLineHeight;
}

@end

@implementation IndexTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    [self followScrollView:self.tableView usingTopConstraint:self.topConstraint withDelay:65];
//    [self setShouldScrollWhenContentFits:YES];
    
//    self.navigationController.navigationBar.translucent = YES;    
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;

    UIAlertView *loadAlert = [[UIAlertView alloc] initWithTitle:@"Loading.."
                                message:nil
                       cancelButtonItem:nil
                       otherButtonItems:nil, nil];
    [loadAlert show];
    
    
    
    [self.tableView.layer setBackgroundColor:[UIColor colorWithRed:0.92 green:0.92 blue:0.93 alpha:1].CGColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    pictures = [NSMutableArray new];
    nextId = @"0";
    titleLabelOneLineHeight = [self calculateLabelHeight:@"" canputwidth:self.tableView.frame.size.width - 132 font:[IndexTableViewCell titleFont]];
    
    [self loadData:loadAlert];
    
}

- (void)loadData:(UIAlertView *) alert{
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc]init];
    [data setValue:nextId forKey:@"next_id"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"application/json"]];
    [manager GET:[NSString stringWithFormat:@"http://ios.ioa.tw/api/v1/next_pictures"]
      parameters:data
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
//             NSLog(@"%@", responseObject);
             if ([[responseObject objectForKey:@"status"] boolValue]) {
                 for (NSMutableDictionary *picture in [responseObject objectForKey:@"pictures"]) {
                     [pictures addObject: picture];
                 }
                 nextId = [[NSString alloc] initWithFormat:@"%@", [responseObject objectForKey:@"next_id"]];
             }
             
             if (alert != nil)
                 [alert dismissWithClickedButtonIndex:-1 animated:YES];

             [self.tableView reloadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"%@", error);
    }];
    
    
//
//
//    MyHttp *http = [MyHttp new];
//    NSMutableDictionary *vars = [NSMutableDictionary new];
//    [vars setObject:nextId == nil ? @"0" : nextId forKey:@"next_id"];
//    
//    [http getURL:@"http://ios.ioa.tw/api/next_pictures" vars: vars completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//        
//        NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        
//        if ([[result objectForKey:@"status"] boolValue]) {
//            for (NSMutableDictionary *picture in [result objectForKey:@"pictures"]) {
//                [pictures addObject: picture];
//            }
//            nextId = [[NSString alloc] initWithFormat:@"%@", [result objectForKey:@"next_id"]];
//            
//            if ([nextId doubleValue] >= 0)
//                isLoading = NO;
//        }
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (alert != nil)
//                [alert dismissWithClickedButtonIndex:-1 animated:YES];
//            
//            [self.tableView reloadData];
//        });
//        
//    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"%li", indexPath.row);
//    if (indexPath.row == 0) {
//        [self showNavbar];
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    double gradient = [[[pictures objectAtIndex:indexPath.row] objectForKey:@"gradient"] floatValue];
    
    float maxWidth = self.tableView.frame.size.width;
    
    float titleLableHeight = [self calculateLabelHeight: [[pictures objectAtIndex:indexPath.row] objectForKey:@"title"] canputwidth:maxWidth - 132 font:[IndexTableViewCell titleFont]];
    
    if (titleLableHeight > titleLabelOneLineHeight * 4) {
        titleLableHeight = titleLabelOneLineHeight * 4;
    }
    
    return ((self.tableView.frame.size.width - 20) * gradient) + 150 + titleLableHeight + 20;
}
-(float) calculateLabelHeight:(NSString *)string canputwidth:(int)canputwidth font:(UIFont *)font {
    return [string boundingRectWithSize:CGSizeMake(canputwidth, MAXFLOAT)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName:font}
                                            context:nil].size.height;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [pictures count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    IndexTableViewCell *cell = (IndexTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"IndexTableViewCell"];
    if(!cell){
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"IndexTableViewCell" owner:self options:nil];
        cell = [nibs objectAtIndex:0];
    }
    
    [cell initUI:[pictures objectAtIndex:indexPath.row] w:self.tableView.frame.size.width];
    
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

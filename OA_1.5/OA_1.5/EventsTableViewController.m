//
//  EventsTableViewController.m
//  OA_1.5
//
//  Created by OA Wu on 2015/6/16.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "EventsTableViewController.h"

@interface EventsTableViewController () {
    NSMutableDictionary *events;
    NSString *nextId;
    NSString *choiceId;
}

@end

@implementation EventsTableViewController

-(void)addEvent:(id)sender {
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"新增活動"
                                                     message:@"請輸入活動名稱"
                                                    delegate:self
                                           cancelButtonTitle:@"取消"
                                           otherButtonTitles:@"確定",nil];
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField *textField = [alert textFieldAtIndex:0];
    [textField setPlaceholder:@"請輸入活動名稱.."];
    
    [alert show];
    
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if ([alertView.title isEqual:@"新增活動"] && (buttonIndex == 1)) {
        NSString *title = [alertView textFieldAtIndex:0].text;

        if (title.length > 0) {
            [alertView dismissWithClickedButtonIndex:-1 animated:YES];

            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Loading..." message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [myAlertView show];
            
            MyHttp *http = [MyHttp new];
            NSMutableDictionary *vars = [NSMutableDictionary new];
            [vars setObject:title forKey:@"title"];
    
            [http postURL:@"http://ios.ioa.tw/api/add_event" vars: vars completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
    
                NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSString *title = [[NSString alloc] initWithFormat:[[result objectForKey:@"status"] boolValue] ? @"新增成功！" : @"新增失敗！"];
    
                dispatch_async(dispatch_get_main_queue(), ^{
                    [myAlertView dismissWithClickedButtonIndex:-1 animated:YES];
                    
                    UIAlertView *ok = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
                    [ok show];
                });
            }];
        }
    } else if ([alertView.title isEqual:@"新增成功！"]) {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Loading..." message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [myAlertView show];
        [self loadData: myAlertView];
    } else if ([alertView.title isEqual:@"刪除成功！"] || [alertView.title isEqual:@"刪除失敗！"]) {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Loading..." message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [myAlertView show];
        [self loadData: myAlertView];
    }

}
- (void)loadData:(UIAlertView *) alert{
    events = [NSMutableDictionary new];
    nextId = [[NSString alloc] initWithFormat:@"0"];
    
    MyHttp *http = [MyHttp new];
    NSMutableDictionary *vars = [NSMutableDictionary new];
    [vars setObject:nextId forKey:@"next_id"];
    [http getURL:@"http://ios.ioa.tw/api/events" vars: vars completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        if ([[result objectForKey:@"status"] boolValue]) {
            for (NSMutableDictionary *event in [result objectForKey:@"events"]) {
                [events setObject:[[NSString alloc] initWithFormat:@"%@", [event objectForKey:@"title"]] forKey:[[NSString alloc] initWithFormat:@"%@", [event objectForKey:@"id"]]];
            }
            nextId = [result objectForKey:@"next_id"];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [alert dismissWithClickedButtonIndex:-1 animated:YES];
        });
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem.title = @"編輯";
    [self.navigationItem.rightBarButtonItem setAction:@selector(editButtonPress:)];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addEvent:)];

    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Loading..." message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [myAlertView show];
    [self loadData:myAlertView];
    
}
- (void)updateEvent:(NSString *) id title:(NSString *)title {
    [events setObject:title forKey:id];
    [self.tableView reloadData];
}
//delete
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Loading..." message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [myAlertView show];
    
    NSArray *sortedKeys = [[events allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return [obj2 integerValue] > [obj1 integerValue];
    }];
    
    MyHttp *http = [MyHttp new];
    NSMutableDictionary *vars = [NSMutableDictionary new];
    [vars setObject:[sortedKeys objectAtIndex:indexPath.row] forKey:@"id"];
    
    [http postURL:@"http://ios.ioa.tw/api/delete_event" vars: vars completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSString *title = [[NSString alloc] initWithFormat:[[result objectForKey:@"status"] boolValue] ? @"刪除成功！" : @"刪除失敗！"];


        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[result objectForKey:@"status"] boolValue]) {
                [events removeObjectForKey:[sortedKeys objectAtIndex:indexPath.row]];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
            }
            [myAlertView dismissWithClickedButtonIndex:-1 animated:YES];
            
            UIAlertView *ok = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
            [ok show];
            
        });
    }];
    
}
- (IBAction)editButtonPress: (UIBarButtonItem *)sender {
    if (self.tableView.isEditing) {
        sender.title = @"編輯";
        self.tableView.editing = NO;
    } else {
        sender.title = @"完成";
        self.tableView.editing = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    [self.tableView reloadData]; // to reload selected cell
}
//sort
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
//    return YES;
//}
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
//
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *sortedKeys = [[events allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return [obj2 compare:obj1];
    }];
    
    choiceId = [sortedKeys objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"cellSegue" sender:self];
}
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    NSLog(@"1");
////    [self.navigationController setNavigationBarHidden:YES animated:animated];
//}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Make sure your segue name in storyboard is the same as this line

    if ([[segue identifier] isEqualToString:@"cellSegue"]) {

        EventViewController *event = [segue destinationViewController];
        event.backdelegate = self;
        [event prassEventId:choiceId title:[events objectForKey:choiceId]];
        //if you need to pass data to the next controller do it here
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {    // Return the number of rows in the section.
    return [events count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }

    NSArray *sortedKeys = [[events allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
                               return [obj2 integerValue] > [obj1 integerValue];
                           }];
    cell.textLabel.text = [events objectForKey:[sortedKeys objectAtIndex:indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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

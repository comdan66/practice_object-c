//
//  MyTableViewController.m
//  OA_2.0
//
//  Created by OA Wu on 2015/6/19.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "MyTableViewController.h"

@interface MyTableViewController (){
    NSMutableArray *pictures;
    NSString *nextId;
    BOOL isLoading;
}


@end

@implementation MyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//    rgba(233, 234, 237, 1)
    
    UIAlertView *loadingAlertView = [[UIAlertView alloc] initWithTitle:@"Loading..." message:@"" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [loadingAlertView show];
    
    isLoading = NO;
    pictures = [NSMutableArray new];
    
    [self.tableView.layer setBackgroundColor:[UIColor colorWithRed:233.0/255.0 green:234.0/255.0 blue:237.0/255.0 alpha:1].CGColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self loadData:loadingAlertView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [pictures count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    double gradient = [[[pictures objectAtIndex:indexPath.row] objectForKey:@"gradient"] floatValue];
    return (self.tableView.frame.size.width + 16) * gradient + 135;
}
//-(UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset {
//    UIGraphicsBeginImageContext(image.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(context, 2);
//    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
//    CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f, image.size.height - inset * 2.0f);
//    CGContextAddEllipseInRect(context, rect);
//    CGContextClip(context);
//    
//    [image drawInRect:rect];
//    CGContextAddEllipseInRect(context, rect);
//    CGContextStrokePath(context);
//    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return newimg;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyTableViewCell *cell = (MyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MyTableViewCell"];
    if(!cell){
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"MyTableViewCell" owner:self options:nil];
        cell = [nibs objectAtIndex:0];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [cell.borderView.layer setBorderColor:[UIColor colorWithRed:208.0/255.0 green:209.0/255.0 blue:213.0/255.0 alpha:1].CGColor];
    [cell.borderView.layer setBorderWidth:1.0f];
    [cell.borderView.layer setCornerRadius:2];
    [cell.borderView setClipsToBounds:YES];
    
    [cell.contentView.layer setBackgroundColor:[UIColor colorWithRed:233.0/255.0 green:234.0/255.0 blue:237.0/255.0 alpha:1].CGColor];
    
    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:cell.pictureImageView];
    [cell.pictureImageView setImageURL:[NSURL URLWithString:[[pictures objectAtIndex:indexPath.row] objectForKey:@"url"]]];
    [cell.pictureImageView setContentMode:UIViewContentModeScaleToFill];
    
    
    [cell.avatarView.layer setBorderColor:[UIColor colorWithRed:39.0/255.0 green:40.0/255.0 blue:34.0/255.0 alpha:0.4].CGColor];
    [cell.avatarView.layer setBorderWidth:1.0f];
    [cell.avatarView.layer setCornerRadius:35];
    [cell.avatarView.layer setShadowColor:[UIColor colorWithRed:39.0/255.0 green:40.0/255.0 blue:34.0/255.0 alpha:1].CGColor];
    [cell.avatarView.layer setShadowOffset:CGSizeMake(2.4f, 2.0f)];
    [cell.avatarView.layer setShadowRadius:5.0f];
    [cell.avatarView.layer setShadowOpacity:0.5f];
    
    [[AsyncImageLoader sharedLoader] cancelLoadingImagesForTarget:cell.avatarImageView];
    [cell.avatarImageView setImageURL:[NSURL URLWithString:@"https://fbcdn-sphotos-e-a.akamaihd.net/hphotos-ak-xpa1/v/t1.0-9/11048657_1080777421935599_5837445915403701082_n.jpg?oh=2443543609875efd1cfbeb180ce4eb6f&oe=5632E7AC&__gda__=1442328774_767b4bf2cebffa46d3e54485004b535b"]];
    [cell.avatarImageView.layer setCornerRadius:35];
    [cell.avatarImageView setClipsToBounds:YES];

    
    [cell.userNameLabel setText:@"OA"];

    
    [cell.titleLabel setText:[[pictures objectAtIndex:indexPath.row] objectForKey:@"title"]];
    [cell.titleLabel setTextColor:[UIColor colorWithRed:39.0/255.0 green:40.0/255.0 blue:34.0/255.0 alpha:0.8]];

    
    [cell.likeButton setTitle:@"已按讚" forState:UIControlStateNormal];
    [cell.likeButton setTitleColor:[UIColor colorWithRed:77.0/255.0 green:79.0/255.0 blue:88.0/255.0 alpha:0.85] forState:UIControlStateNormal];
    [cell.likeButton.titleLabel setFont:[UIFont boldSystemFontOfSize:[UIFont systemFontSize]]];

    [cell.commentButton setTitle:@"留言(2)" forState:UIControlStateNormal];
    [cell.commentButton setTitleColor:[UIColor colorWithRed:137.0/255.0 green:143.0/255.0 blue:156.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    [cell.commentButton addTarget:self action:@selector(pictureInfoSegue:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}
- (void)pictureInfoSegue:(MyTableViewCell *)cell {
    [self performSegueWithIdentifier:@"pictureInfoSegue" sender:cell];
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

            if ([nextId doubleValue] >= 0)
                isLoading = NO;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (alert != nil)
                [alert dismissWithClickedButtonIndex:-1 animated:YES];
            
            [self.tableView reloadData];
        });
        
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (isLoading)
        return;
    
    if ((scrollView.contentOffset.y > scrollView.contentSize.height - scrollView.frame.size.height * 2)) {
        [self loadData:nil];
    }
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

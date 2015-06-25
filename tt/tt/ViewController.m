//
//  ViewController.m
//  tt
//
//  Created by OA Wu on 2015/6/25.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self styleNavBar];
    
    __weak id weakSelf = self;
    self.navigationController.interactivePopGestureRecognizer.delegate = weakSelf;
}
- (void)styleNavBar {
    NSString *backArrowString = @"\U000025C0\U0000FE0E"; //BLACK LEFT-POINTING TRIANGLE PLUS VARIATION SELECTOR
    
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:backArrowString style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    UINavigationBar *newNavBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 64.0)];
//    [newNavBar setTintColor:[UIColor redColor]];
//    UINavigationItem *newItem = [[UINavigationItem alloc] init];
//    newItem.title = @"Paths";
//    
//    // BackButtonBlack is an image we created and added to the app’s asset catalog
//    UIImage *backButtonImage = [UIImage imageNamed:@"dRXMl.png"];
//    
//    // any buttons in a navigation bar are UIBarButtonItems, not just regular UIButtons. backTapped: is the method we’ll call when this button is tapped
//    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction)];
//    [backBarButtonItem setTitle:@"asdadd"];
//    // the bar button item is actually set on the navigation item, not the navigation bar itself.
//    newItem.leftBarButtonItem = backBarButtonItem;
//    
//    [newNavBar setItems:@[newItem]];
//    [self.view addSubview:newNavBar];
    
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] init];
//    [self.navigationItem.leftBarButtonItem setTitle:@"❮ Back"];
//    [self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStyleDone];
//    [self.navigationItem.leftBarButtonItem setTarget:self];
//    [self.navigationItem.leftBarButtonItem setAction:@selector(backButtonAction)];
    
    
    // 1. hide the existing nav bar
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
//    // 2. create a new nav bar and style it
//    UINavigationBar *newNavBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 64.0)];
//    [newNavBar setTintColor:[UIColor whiteColor]];
//
//    // 3. add a new navigation item w/title to the new nav bar
//    UINavigationItem *newItem = [[UINavigationItem alloc] init];
//    newItem.title = @"Paths";
//    [newNavBar setItems:@[newItem]];
////
////    // 4. add the nav bar to the main view
////    [self.view addSubview:newNavBar];
    
    
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    UINavigationBar *newNavBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 64.0)];
//    [newNavBar setTintColor:[UIColor whiteColor]];
//    UINavigationItem *newItem = [[UINavigationItem alloc] init];
//    newItem.title = @"Paths";
//    
//    // BackButtonBlack is an image we created and added to the app’s asset catalog
//    UIImage *backButtonImage = [UIImage imageNamed:@"BackButtonBlack"];
//    
//    // any buttons in a navigation bar are UIBarButtonItems, not just regular UIButtons. backTapped: is the method we’ll call when this button is tapped
//    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(backTapped:)];
//    
//    // the bar button item is actually set on the navigation item, not the navigation bar itself.
//    newItem.leftBarButtonItem = backBarButtonItem;
//    
//    [newNavBar setItems:@[newItem]];
//    [self.view addSubview:newNavBar];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(0.0, 1.0);
    shadow.shadowColor = [UIColor whiteColor];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil]
//
     setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor blackColor],
       NSShadowAttributeName:shadow,
       NSFontAttributeName:[UIFont boldSystemFontOfSize:12.0]
       }
     forState:UIControlStateNormal];
    
}
-(void)backButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

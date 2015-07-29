//
//  ViewController.m
//  Arc
//
//  Created by OA Wu on 2015/7/7.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "ViewController.h"

#import "TestView.h"

@interface ViewController () {
    
//    MBProgressHUD *HUD;
}

@end

bool isShown = false;
@implementation ViewController
- (void)myTask {
    // Do something usefull in here instead of sleeping ...
    sleep(3);
}

- (void)viewDidUnload {
    [super viewDidUnload];
    NSLog(@"=======d");
}
- (void)hudWasHidden:(MBProgressHUD *)hud {
//    [HUD removeFromSuperview];
//    HUD = nil;
    NSLog(@"ddd");
}
- (IBAction)sss:(id)sender {
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    HUD.delegate = self;
    
//    [TestView show];
    
//    CABasicAnimation *basic2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    [basic2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
//    [basic2 setFromValue:[NSNumber numberWithFloat:1]];
//    [basic2 setToValue:[NSNumber numberWithFloat:.3]];
////    
////    CAKeyframeAnimation *keyframe2 = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.x"];
////    keyframe2.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0],[NSNumber numberWithFloat:M_PI], nil];
//    
//    CAAnimationGroup *group = [CAAnimationGroup animation];
//    
//    [group setDuration:2];
//    [group setAnimations:[NSArray arrayWithObjects:basic2, nil]];
//    
//    [self.imageView.layer addAnimation:group forKey:@"animationKey"];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    DTAlertView *alertView = [DTAlertView alertViewWithTitle:@"Demo" message:@"I'm alert view." delegate:self cancelButtonTitle:@"Cancel" positiveButtonTitle:@"OK"];
//    [alertView setDismissAnimationWhenButtonClicked:DTAlertViewAnimationSlideRight];
//    [alertView showWithAnimation:DTAlertViewAnimationSlideRight];
    
//    NSUInteger a;
    // Do any additional setup after loading the view, typically from a nib.
    
    //	NSURL *URL = [NSURL URLWithString:@"http://a1408.g.akamai.net/5/1408/1388/2005110403/1a1a1ad948be278cff2d96046ad90768d848b41947aa1986/sample_iPod.m4v.zip"];
    //	NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    //
    //	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    //	[connection start];
    //	[connection release];
    //
//    
//    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    HUD.delegate = self;
//
//    
//        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//        [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"application/json"]];
//        [manager POST:[NSString stringWithFormat:@"http://catmap.ioa.tw/api/v1/test"]
//           parameters:nil
//              success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                  [self myTask];
//                  NSLog(@"%@", responseObject);
//                  	[HUD hide:YES];
//                  
//              }
//              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//              }
//         ];
    
//    HUD = [[MBProgressHUD alloc] initWithView:self.view];
//    [self.view addSubview:HUD];
//    
//    HUD.mode = MBProgressHUDModeAnnularDeterminate;
//    
//    HUD.delegate = self;
//    HUD.labelText = @"Loading";
//    
//    [HUD showWhileExecuting:@selector(myProgressTask) onTarget:self withObject:nil animated:YES];
    
//    CAMediaTimingFunction *func = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    for (int i = 0; i < 4; i++) {
//        float *values = malloc(sizeof(float) * 2);
//        [func getControlPointAtIndex:i values:values];
//        NSLog(@"Control point %i: (%f, %f)", i+1, values[0], values[1]);
//        
//        HUD.progress = values[0];
//        usleep(500000);
//        free(values);
//    }
//                      	[HUD hide:YES];
}

//- (void)myProgressTask {
//    // This just increases the progress indicator in a loop
////    float progress = 0.0f;
////    while (progress < 1.0f) {
////        progress += 0.01f;
////        HUD.progress = progress;
////        usleep(50000);
////    }
//    CAMediaTimingFunction *func = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
////    NSLog(@"%@", func);
//    for (int i = 0; i < 10; i++) {
//        float *values = malloc(sizeof(float) * 2);
//        [func getControlPointAtIndex:i values:values];
//        NSLog(@"Control point %i: (%f, %f)", i+1, values[0], values[1]);
//
////        HUD.progress = values[0];
////        usleep(500000);
////        free(values);
//    }
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

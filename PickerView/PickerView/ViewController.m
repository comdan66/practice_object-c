//
//  ViewController.m
//  PickerView
//
//  Created by OA Wu on 2015/6/12.
//  Copyright (c) 2015年 OA Wu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    list1 = [NSMutableArray new];
    list2 = [NSMutableArray new];
    
    [list1 addObject:@"美洲"];
    [list1 addObject:@"亞洲"];
    [list1 addObject:@"歐洲"];
    [list1 addObject:@"大洋洲"];
    [list1 addObject:@"澳洲"];
    
    
    [list2 addObject:@"美國"];
    [list2 addObject:@"英國"];
    [list2 addObject:@"中國"];
    [list2 addObject:@"紐西蘭"];
    [list2 addObject:@"荷蘭"];
    [list2 addObject:@"德國"];
    [list2 addObject:@"台灣"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [list1 count];
    } else if (component == 1) {
        return [list2 count];
    }
    return 0;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (component == 0) {
        return [list1 objectAtIndex:row];
    } else if (component == 1) {
        return [list2 objectAtIndex:row];
    }
    return nil;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        NSLog(@"五大洲選了 %@", [list1 objectAtIndex:row]);
    } else if (component == 1) {
        NSLog(@"國家選了 %@", [list2 objectAtIndex:row]);
    }
}
@end

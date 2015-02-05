//
//  ViewController.m
//  LYCStatusBarAlertDemo
//
//  Created by 北京千锋互联科技有限公司 on 15-2-5.
//  Copyright (c) 2015年 黎跃春. All rights reserved.
//

#import "ViewController.h"
#import "LYCStatusBarAlertHUD.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [[LYCStatusBarAlertHUD sharedInstance] showWithString:@"正在载入,请稍后....."];
    dispatch_queue_t queue = dispatch_queue_create("com.1000phone.liyuechun", DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(queue, ^{
        
        for (int i = 0; i < 10000; i++) {
            NSLog(@"%d", i);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[LYCStatusBarAlertHUD sharedInstance] hide];
        });
    });
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

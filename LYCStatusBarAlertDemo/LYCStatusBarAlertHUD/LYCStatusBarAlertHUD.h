//
//  LYCStatusBarAlertHUD.h
//  LYCStatusBarAlertDemo
//
//  Created by 北京千锋互联科技有限公司 on 15-2-5.
//  Copyright (c) 2015年 黎跃春. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class LYCStatusBarAlertHUD;

@interface LYCStatusBarAlertHUD : NSObject {
    UIWindow* _window;
    UILabel* _label;
    UIImage* _backgroundImage;
    UIImageView* _backgroundImageView;

    NSString* _displayString;
}

@property (nonatomic, retain) UIWindow* window;
@property (nonatomic, retain) UILabel* label;
@property (nonatomic, retain) UIImage* backgroundImage;
@property (nonatomic, retain) UIImageView* backgroundImageView;
@property (nonatomic, copy) NSString* displayString;

+ (LYCStatusBarAlertHUD*)sharedInstance;

- (void)showWithString:(NSString*)string;
- (void)hide;

@end
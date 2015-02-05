//
//  LYCStatusBarAlertHUD.m
//  LYCStatusBarAlertDemo
//
//  Created by 北京千锋互联科技有限公司 on 15-2-5.
//  Copyright (c) 2015年 黎跃春. All rights reserved.
//

#import "LYCStatusBarAlertHUD.h"

/**
 *  状态栏高度
 */
static const CGFloat kStatusBarHeight = 20.0;

/**
 *  屏幕宽度
 */
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

/**
 *  屏幕高度
 */
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

static LYCStatusBarAlertHUD* instance = nil;

@interface LYCStatusBarAlertHUD ()
- (void)setupViewsAndDatas;
- (void)removeViewsAndDatas;
@end

@implementation LYCStatusBarAlertHUD
@synthesize window = _window;
@synthesize label = _label;
@synthesize backgroundImage = _backgroundImage;
@synthesize backgroundImageView = _backgroundImageView;
@synthesize displayString = _displayString;

- (void)dealloc
{
    [self removeViewsAndDatas];
}

#pragma mark - Setter & Getter
- (NSString*)displayString
{
    if (_label == nil) {
        NSLog(@"label == nil");
        return nil;
    }
    return _label.text;
}

- (void)setDisplayString:(NSString*)displayString
{
    if (![displayString isEqualToString:_displayString]) {
        _displayString = [displayString copy];

        if (_label != nil) {
            _label.text = displayString;
            _window.windowLevel = UIWindowLevelAlert;
            [_window makeKeyAndVisible];
        }
    }
}

- (void)setBackgroundImage:(UIImage*)backgroundImage
{
    if (![backgroundImage isEqual:_backgroundImageView]) {
        _backgroundImage = backgroundImage;

        if (_backgroundImageView != nil) {
            _backgroundImageView.image = backgroundImage;
        }
    }
}

#pragma mark - Initialize
- (id)init
{
    self = [super init];
    if (self) {
        [self setupViewsAndDatas];
    }
    return self;
}

+ (LYCStatusBarAlertHUD*)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    instance = [[super allocWithZone:NULL] init];
    });

    return instance;
}

#pragma mark -Instance Methods
- (void)setupViewsAndDatas
{
    CGRect statusBarFrame = CGRectMake(0, 0, SCREEN_WIDTH, kStatusBarHeight);

    // windows
    _window = [[UIWindow alloc]
        initWithFrame:CGRectMake(0, -kStatusBarHeight, SCREEN_WIDTH,
                          kStatusBarHeight)];
    _window.tag = 1;
    _window.windowLevel = UIWindowLevelAlert;
    _window.backgroundColor = [UIColor blackColor];

    // backgroundImage
    self.backgroundImage = [[UIImage imageNamed:@"statusbar_background.png"]
        stretchableImageWithLeftCapWidth:2
                            topCapHeight:0];

    // backgroundImageView
    _backgroundImageView = [[UIImageView alloc] initWithFrame:statusBarFrame];
    _backgroundImageView.image = _backgroundImage;

    // label
    _label = [[UILabel alloc] initWithFrame:statusBarFrame];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor = [UIColor blackColor];
    _label.backgroundColor = [UIColor clearColor];
    _label.adjustsFontSizeToFitWidth = YES;
    _label.minimumScaleFactor = 5.0;

    // views struct
    [_window addSubview:_backgroundImageView];
    [_window addSubview:_label];
    [_window makeKeyAndVisible];
}

- (void)removeViewsAndDatas
{
    _window.windowLevel = UIWindowLevelNormal;
    self.backgroundImage = nil;
    self.displayString = nil;
    self.label = nil;
    self.backgroundImageView = nil;
    self.window = nil;
}

- (void)showWithString:(NSString*)string
{
    self.displayString = string;
    if (_window) {
        _window.windowLevel = UIWindowLevelAlert;
    }

    if ((_window && _window.frame.origin.y == 0)) { //|| [string isEqualToString:_displayString]) {
        return;
    }

    if (!_window) {
        [self setupViewsAndDatas];
        self.displayString = string;
    }
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(hide)
                                               object:nil];

    // animation
    [UIView animateWithDuration:0.6 animations:^{
        
        _window.frame = CGRectMake(0, 0, SCREEN_WIDTH, kStatusBarHeight);

    }];
}

- (void)hide
{
    [UIView animateWithDuration:0.6
                     animations:^{
                     _window.frame = CGRectMake(0, -kStatusBarHeight,
                                                SCREEN_WIDTH, kStatusBarHeight);
                     }];

    UIApplication* app = [UIApplication sharedApplication];
    UIWindow* window = nil;
    for (UIWindow* win in app.windows) {
        if (win.tag == 0) {
            window = win;
            [window makeKeyAndVisible];
        }
    }
}

@end
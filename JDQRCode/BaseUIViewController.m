//
//  BaseUIViewController.m
//  JDQRCode
//
//  Created by 李伟杰 on 2018/6/26.
//  Copyright © 2018年 李伟杰. All rights reserved.
//

#import "BaseUIViewController.h"
#import "IQKeyboardManager.h"
#import <StoreKit/StoreKit.h>
//#import "UIImageUtil.h"
#import "JDCommonNavBar.h"
#import <LocalAuthentication/LocalAuthentication.h>
//#import "FingerprintVerificationController.h"
//#import "CommonWebViewController.h"
//#import "LoginViewController.h"
//#import "WUGesturesUnlockViewController.h"
//#import "MessageListController.h"

@interface BaseUIViewController () <SKStoreProductViewControllerDelegate, JDCommonNavBarDelegate, UIGestureRecognizerDelegate, UIAlertViewDelegate> {
    LAContext *context;
    UIAlertView *alert;
}

@property (assign, nonatomic) BOOL isRealName;

@end

@implementation BaseUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isFirstAppear = YES;

    // 解决ios7 导航栏和状态栏都是不占实际空间的问题
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
//    [self setupNotification];
}

#pragma Notification

//- (void)setupNotification {
//
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(someMethodEnterBackground:) name:UIApplicationDidEnterBackgroundNotification
//                                               object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(someMethodBecomeActive:)
//                                                 name:UIApplicationDidBecomeActiveNotification
//                                               object:nil];
//}

#pragma mark ----------events

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 开启返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    // 导航栏分割线
//    UIImage *shadow = [UIImageUtil imageWithColor:COLOR_GRAY_LIGHT_TXT size:CGSizeMake(kDeviceWidth, 1)];
//    [self.navigationController.navigationBar setShadowImage: shadow];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"CurrentViewController" object:nil userInfo:[NSDictionary dictionaryWithObjectsAndKeys:self, @"lastViewController", nil]];

    // 键盘控制
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = NO;
    [IQKeyboardManager sharedManager].shouldShowToolbarPlaceholder = NO;
    //点击背景收回键盘
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;

    // 友盟统计
    [super viewWillAppear:animated];
//    [MobClick beginLogPageView:[NSString stringWithFormat:@"%@[%@]", NSStringFromClass([self class]), self.title]];//("PageOne"为页面名称，可自定义)
//    [self forcedUpdate];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    // 友盟统计
//    [MobClick endLogPageView:[NSString stringWithFormat:@"%@[%@]", NSStringFromClass([self class]), self.title]];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.navigationController.viewControllers.count <= 1 ) {
        return NO;
    }
    return YES;
}

//定时器闪烁
- (void)timerFlashWith:(id)layer {
    //添加定时器
    NSTimer *timer = [NSTimer new];
    timer =  [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(theTimer:) userInfo:layer repeats:YES];
}

- (void)theTimer:(NSTimer *)timer {
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    shake.fromValue = [NSNumber numberWithFloat:- 5];
    shake.toValue = [NSNumber numberWithFloat:5];
    shake.duration = 0.1;//执行时间
    shake.autoreverses = YES; //是否重复
    shake.repeatCount = 1;//次数
    [timer.userInfo addAnimation:shake forKey:@"shakeAnimation"];
}

//刷新反馈
- (void)reloadFeedback {
    if (@available(iOS 10.0, *)) {
        UIImpactFeedbackGenerator *impactFeedBack = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
        [impactFeedBack prepare];
        [impactFeedBack impactOccurred];
    } else {
//        AudioServicesPlaySystemSound(1519);
    }
}

#pragma mark ----------CustomNavBarDelegate

- (void)onJDCommonNavBarLeftButtonTouch:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 导航按钮

- (void)addLeftNavbarButton:(UIButton *)button {
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setLeftBarButtonItem:buttonItem];
}

- (void)addRightNavbarButton:(UIButton *)button {
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    if (self.navigationItem.rightBarButtonItems) {
        NSArray *rightBarButtonItems = [self.navigationItem.rightBarButtonItems arrayByAddingObject:buttonItem];
        [self.navigationItem setRightBarButtonItems:rightBarButtonItems];
    } else {
        [self.navigationItem setRightBarButtonItem:buttonItem];
    }
}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {

    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    debug_NSLog(@"statusBar.backgroundColor--->%@", statusBar.backgroundColor);
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}
//光标往右偏移uiTextfield
- (void)getRightPointLightTipWithTxf:(UITextField *)txf rightNum:(CGFloat)num {
    UIView *blankView = [[UIView alloc] initWithFrame:CGRectMake(txf.frame.origin.x, txf.frame.origin.y, num, txf.frame.size.height)];
    txf.leftView = blankView;
    txf.leftViewMode = UITextFieldViewModeAlways;  // 这里是用来设置leftView的实现时机的
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell * cell =  [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

//输入框字符串过滤
- (NSString *)getRealStr:(NSString *)str {
    return [str stringByReplacingOccurrencesOfString:@" " withString:@""];
}

@end

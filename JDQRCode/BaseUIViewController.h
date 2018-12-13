//
//  BaseUIViewController.h
//  JDQRCode
//
//  Created by 李伟杰 on 2018/6/26.
//  Copyright © 2018年 李伟杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseUIViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) BOOL isFirstAppear;

/**
返回按钮点击事件 子类可以重写这个方法
*/
- (void)backAction;

// 导航按钮
- (void)addLeftNavbarButton:(UIButton *)button;
- (void)addRightNavbarButton:(UIButton *)button;

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color;

//定时器闪烁
- (void)timerFlashWith:(id)layer;
//刷新反馈
- (void)reloadFeedback;

//- (void)openAppWithIdentifier:(NSString*)appId;
//光标往右偏移uiTextfield
- (void)getRightPointLightTipWithTxf:(UITextField *)txf rightNum:(CGFloat)num;
//是否支持指纹或者面容验证
- (NSUInteger)isCanVerification;
//是否开启指纹或者面部验证
- (BOOL)canFingerprintVerification;
//指纹或者面部验证
- (void)fingerprintVerification;
//是否开启手势验证验证
- (BOOL)canGestureVerification;

//强制更新
- (void)forcedUpdate;

// 判断用户是否允许接收通知
- (BOOL)isUserNotificationEnable;
// 如果用户关闭了接收通知功能，该方法可以跳转到APP设置页面进行修改  iOS版本 >=8.0 处理逻辑
- (void)goToAppSystemSetting;

//输入框字符串过滤
- (NSString *)getRealStr:(NSString *)str;

@end

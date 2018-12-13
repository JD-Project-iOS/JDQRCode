//
//  JDCommonNavBar.h
//  JDQRCode
//
//  Created by 李伟杰 on 2018/6/26.
//  Copyright © 2018年 李伟杰. All rights reserved.
//

#import <UIKit/UIKit.h>

//@"icon_back_black_nav";
//NSString *const CustomNavBarStyleWhiteBackImageName       = @"icon_back_black_nav";
//NSString *const NavbarRightShareImageName                 = @"icon_nav_share_black";

@protocol JDCommonNavBarDelegate <NSObject>

@optional

- (void)onJDCommonNavBarLeftButtonTouch:(UIButton *)sender;
- (void)onJDCommonNavBarRightButtonTouch:(UIButton *)sender;

@end

@interface JDCommonNavBar : UIView

@property (nonatomic, weak)IBOutlet id <JDCommonNavBarDelegate>delegate;
@property (nonatomic, strong) UIButton *buttonRight;

- (void)initWithLeftButtonImageName:(NSString *)leftButtonImageName
            andRightButtonImageName:(NSString *)rightButtonImageName
                           andTitle:(id)title;

- (void)reloadTitleName:(id)title color:(UIColor *)color;
- (void)setRightButtonTitle:(NSString *)title WithColor:(UIColor *)color;
- (void)setLeftButtonTitle:(NSString *)title WithColor:(UIColor *)color;
- (void)setRightButtonHidden;

@end

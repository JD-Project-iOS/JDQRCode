//
//  JDCommonNavBar.m
//  JDQRCode
//
//  Created by 李伟杰 on 2018/6/26.
//  Copyright © 2018年 李伟杰. All rights reserved.
//

#import "JDCommonNavBar.h"

const float HAJZB_CustomNavBarButtonWidth = 60.0;
const float HAJZB_CustomNavBarButtonHeight = 44.0;

@interface JDCommonNavBar ()

@property (nonatomic, strong) UIButton *buttonLeft;
@property (nonatomic, strong) UILabel  *labelTitle;

@end

@implementation JDCommonNavBar

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
        [self layoutSubView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initSubView];
        [self layoutSubView];
    }
    return self;
}

#pragma mark ---- initView

- (void)initSubView {
    self.width = kScreenWidth;
    [self initButtonLeft];
    [self initButtonRight];
    [self initLabelTitle];
}

- (void)initButtonLeft {
    self.buttonLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    _buttonLeft.backgroundColor = [UIColor clearColor];
    [_buttonLeft addTarget:self action:@selector(leftButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_buttonLeft];

    _buttonLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _buttonLeft.contentEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
}

- (void)initButtonRight {
    self.buttonRight = [UIButton buttonWithType:UIButtonTypeCustom];
    _buttonRight.backgroundColor = [UIColor clearColor];
    [_buttonRight addTarget:self action:@selector(rightButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_buttonRight];
}

- (void)initLabelTitle {
    self.labelTitle = [[UILabel alloc] init];
    _labelTitle.font = [UIFont fontWithName:@"HelveticaNeue" size:20.f];
    _labelTitle.backgroundColor = [UIColor clearColor];
    [self addSubview:_labelTitle];
}

#pragma mark - layout method

- (void)layoutSubView {
    self.frame = CGRectMake(0, 0, kScreenWidth, kStatusBarAndNavigationBarHeight);
//    self.backgroundColor = [UIColor whiteColor];
    _buttonLeft.frame = CGRectMake(0, kStatusBarAndNavigationBarHeight - HAJZB_CustomNavBarButtonHeight, HAJZB_CustomNavBarButtonWidth, HAJZB_CustomNavBarButtonHeight);
    _buttonRight.frame = CGRectMake(kScreenWidth - HAJZB_CustomNavBarButtonWidth - 10, kStatusBarAndNavigationBarHeight - HAJZB_CustomNavBarButtonHeight, HAJZB_CustomNavBarButtonWidth + 10, HAJZB_CustomNavBarButtonHeight);
    _labelTitle.frame = CGRectMake(50, kStatusBarAndNavigationBarHeight - 30, kScreenWidth - 100, 20);
    _labelTitle.textAlignment = NSTextAlignmentCenter;
}

#pragma mark - event response

- (void)leftButtonTouch:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(onJDCommonNavBarLeftButtonTouch:)]) {
        [_delegate onJDCommonNavBarLeftButtonTouch:sender];
    }
}

- (void)rightButtonTouch:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(onJDCommonNavBarRightButtonTouch:)]) {
        [_delegate onJDCommonNavBarRightButtonTouch:sender];
    }
}

#pragma mark ---- private

- (void)initLeftButtonImageName:(NSString *)leftButtonImageName {
    if (leftButtonImageName) {
        if ([leftButtonImageName isEqualToString:@""]) {
            _buttonLeft.hidden = YES;
            _buttonLeft.userInteractionEnabled = NO;
            return;
        }
        UIImage *image = [UIImage imageNamed:leftButtonImageName];
        [_buttonLeft setImage:image forState:UIControlStateNormal];
    }
}

- (void)initRightButtonImageName:(NSString *)rightButtonImageName {
    if (rightButtonImageName) {
        if ([rightButtonImageName isEqualToString:@""]) {
            _buttonRight.hidden = YES;
            _buttonRight.userInteractionEnabled = NO;
            return;
        }
        UIImage *image = [UIImage imageNamed:rightButtonImageName];
        [_buttonRight setImage:image forState:UIControlStateNormal];
    }
}

- (void)initTitle:(id)title {
    if (title) {
        if ([title isKindOfClass:[NSString class]]) {
            _labelTitle.text = title;
        }
        if ([title isKindOfClass:[NSMutableAttributedString class]]) {
            _labelTitle.attributedText = title;
        }
    }
}

#pragma mark ---- public

- (void)initWithLeftButtonImageName:(NSString *)leftButtonImageName
            andRightButtonImageName:(NSString *)rightButtonImageName
                           andTitle:(id)title{
    [self initLeftButtonImageName:leftButtonImageName];
    [self initRightButtonImageName:rightButtonImageName];
    [self initTitle:title];
    [self layoutSubView];
}

- (void)reloadTitleName:(id)title color:(UIColor *)color{
    [self initTitle:title];
    _labelTitle.textColor = color;
}

- (void)setRightButtonTitle:(NSString *)title WithColor:(UIColor *)color {
    _buttonRight.layer.cornerRadius = 0;
    [_buttonRight setTitle:title forState:UIControlStateNormal];
    _buttonRight.titleLabel.font = [UIFont systemFontOfSize:14.f];
    _buttonRight.titleLabel.textAlignment = NSTextAlignmentRight;
    [_buttonRight setTitleColor:color forState:UIControlStateNormal];
    [_buttonRight setTitleColor:COLOR_GRAY_LIGHT_TXT forState:UIControlStateHighlighted];
    [_buttonRight setTitleEdgeInsets:UIEdgeInsetsMake(10, 0, 0, 0)];
}

- (void)setLeftButtonTitle:(NSString *)title WithColor:(UIColor *)color {
    _buttonLeft.layer.cornerRadius = 0;
    [_buttonLeft setTitle:title forState:UIControlStateNormal];
    _buttonLeft.titleLabel.font = [UIFont systemFontOfSize:14.f];
    _buttonLeft.titleLabel.textAlignment = NSTextAlignmentRight;
    [_buttonLeft setTitleColor:color forState:UIControlStateNormal];
    [_buttonLeft setTitleColor:COLOR_GRAY_LIGHT_TXT forState:UIControlStateHighlighted];
    [_buttonLeft setTitleEdgeInsets:UIEdgeInsetsMake(10, 0, 0, 0)];
}

- (void)setRightButtonHidden {
    _buttonRight.hidden = YES;
}

@end

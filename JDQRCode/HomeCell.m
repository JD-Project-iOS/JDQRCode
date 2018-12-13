//
//  HomeCell.m
//  JDQRCode
//
//  Created by 李伟杰 on 2018/12/5.
//  Copyright © 2018 jd. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.image = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.topView = [[UIView alloc] initWithFrame:CGRectZero];

        [self addSubview:self.image];
        [self addSubview:self.titleLabel];
        [self addSubview:self.topView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.image.frame = self.bounds;
    self.image.layer.masksToBounds = YES;
    self.image.layer.cornerRadius = 5;
    //    self.titleLabel.layer.masksToBounds = YES;
    //    self.titleLabel.layer.cornerRadius = 5;
    self.topView.layer.masksToBounds = YES;
    self.topView.layer.cornerRadius = 5;

    self.titleLabel.frame = CGRectMake(0, self.image.height - 20, self.image.width, 20);
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.backgroundColor = COLOR_RGBA(51, 51, 51, 0.3);
    //    self.titleLabel.shadowColor = COLOR_RGBA(51, 51, 51, 0.6);
    self.titleLabel.font = [UIFont systemFontOfSize:13.f];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;

    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.titleLabel.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [CAShapeLayer new];
    maskLayer.frame = self.titleLabel.bounds;
    maskLayer.path = maskPath.CGPath;
    self.titleLabel.layer.mask = maskLayer;

    self.topView.frame = self.bounds;
    self.topView.backgroundColor = COLOR_RGBA(51, 51, 51, 0.3);
    self.topView.hidden = YES;
}

@end

//
//  UserUtil.h
//  JDQRCode
//
//  Created by 李伟杰 on 2018/6/26.
//  Copyright © 2018年 李伟杰. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface UserUtil : NSObject

+ (NSMutableDictionary *)findPath;


+ (void)saveObject:(id)object key:(NSString *)key;


//退出清除用户信息
+ (void)clearUserData;

////清理其他缓存
//+ (void)clearOtherData;
//
////字体间距，和行间距
//+ (CGRect)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(CGFloat)font needWidth:(CGFloat)needWidth lineSpacing:(CGFloat)lineSpacing;
//
//+ (CGRect)setValue:(NSString*)str withFont:(CGFloat)font needWidth:(CGFloat)needWidth lineSpacing:(CGFloat)lineSpacing;
//
//+ (void)setLabel:(UILabel*)label withValue:(NSString*)str withFont:(CGFloat)font needWidth:(CGFloat)needWidth lineSpacing:(CGFloat)lineSpacing;
@end

//
//  UserUtil.m
//  JDQRCode
//
//  Created by 李伟杰 on 2018/6/26.
//  Copyright © 2018年 李伟杰. All rights reserved.
//

//#import "FilePathOperator.h"
//#import "NSDate+format.h"
//#import "NSString+MD5.h"
#import "UserUtil.h"

@implementation UserUtil

+ (NSMutableDictionary *)findPath {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:[user objectForKey:kUserDataPath]];
    return userDic;
}

+ (void)saveObject:(id)object key:(NSString *)key {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:[user objectForKey:kUserDataPath]];
    [userDic setObject:object forKey:key];
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:userDic];
    [user setObject:dic forKey:kUserDataPath];
}


////自动拼接字典成URL字符串
//+ (NSString *)dictionaryToParamsStr:(NSDictionary *)data {
//    __block NSString *paramsStr = @"";
//    [data enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
//        paramsStr = [NSString stringWithFormat:@"%@&%@=%@", paramsStr, key, obj];
//    }];
//    return paramsStr;
//}
//
//#pragma mark - device
//
//+ (CGFloat)deviceWidth {
//    static CGFloat width;
//    static dispatch_once_t predicate;
//    dispatch_once(&predicate, ^{
//        width = [[UIScreen mainScreen]bounds].size.width;
//    });
//    return width;
//}
//
//+ (CGFloat)deviceHeight {
//    static CGFloat height;
//    static dispatch_once_t predicate;
//    dispatch_once(&predicate, ^{
//        height = [[UIScreen mainScreen]bounds].size.height;
//    });
//    return height;
//}

//退出清除用户信息
+ (void)clearUserData {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserDataPath];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

////字体间距，和行间距
//+ (CGRect)setLabelSpace:(UILabel*)label withValue:(NSString*)str withFont:(CGFloat)font needWidth:(CGFloat)needWidth lineSpacing:(CGFloat)lineSpacing {
//    NSMutableParagraphStyle *pStyle = [[NSMutableParagraphStyle alloc] init];
//    pStyle.lineBreakMode = NSLineBreakByCharWrapping;
//    pStyle.alignment = NSTextAlignmentLeft;
//    pStyle.lineSpacing = lineSpacing; //设置行间距
//    pStyle.hyphenationFactor = 1.0;
//    pStyle.firstLineHeadIndent = 0.0;
//    pStyle.paragraphSpacingBefore = 0.0;
//    pStyle.headIndent = 0;
//    pStyle.tailIndent = 0;
//    //设置字间距 1.5f
//    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font], NSParagraphStyleAttributeName:pStyle, NSKernAttributeName:@1.5f
//                          };
//    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
//    label.attributedText = attributeStr;
//
//    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
//
//    CGRect rect = [str boundingRectWithSize:CGSizeMake(needWidth, CGFLOAT_MAX) options:options attributes:dic context:nil];
//
//    return rect;
//}
//
//+ (CGRect)setValue:(NSString*)str withFont:(CGFloat)font needWidth:(CGFloat)needWidth lineSpacing:(CGFloat)lineSpacing {
//    NSMutableParagraphStyle *pStyle = [[NSMutableParagraphStyle alloc] init];
//    pStyle.lineBreakMode = NSLineBreakByCharWrapping;
//    pStyle.alignment = NSTextAlignmentLeft;
//    pStyle.lineSpacing = lineSpacing; //设置行间距
//    pStyle.hyphenationFactor = 1.0;
//    pStyle.firstLineHeadIndent = 0.0;
//    pStyle.paragraphSpacingBefore = 0.0;
//    pStyle.headIndent = 0;
//    pStyle.tailIndent = 0;
//    //设置字间距 1.5f
//    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font], NSParagraphStyleAttributeName:pStyle, NSKernAttributeName:@1.5f
//                          };
////    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
////    label.attributedText = attributeStr;
//
//    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
//
//    CGRect rect = [str boundingRectWithSize:CGSizeMake(needWidth, CGFLOAT_MAX) options:options attributes:dic context:nil];
//
//    return rect;
//}
//
//+ (void)setLabel:(UILabel*)label withValue:(NSString*)str withFont:(CGFloat)font needWidth:(CGFloat)needWidth lineSpacing:(CGFloat)lineSpacing {
//    NSMutableParagraphStyle *pStyle = [[NSMutableParagraphStyle alloc] init];
//    pStyle.lineBreakMode = NSLineBreakByCharWrapping;
//    pStyle.alignment = NSTextAlignmentLeft;
//    pStyle.lineSpacing = lineSpacing; //设置行间距
//    pStyle.hyphenationFactor = 1.0;
//    pStyle.firstLineHeadIndent = 0.0;
//    pStyle.paragraphSpacingBefore = 0.0;
//    pStyle.headIndent = 0;
//    pStyle.tailIndent = 0;
//    //设置字间距 1.5f
//    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font], NSParagraphStyleAttributeName:pStyle, NSKernAttributeName:@1.5f
//                          };
//    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
//    label.attributedText = attributeStr;
//}

@end

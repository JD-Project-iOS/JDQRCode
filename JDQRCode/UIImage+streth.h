//
//  UIImage+streth.h
//  JDQRCode
//
//  Created by 李伟杰 on 2018/6/26.
//  Copyright © 2018年 李伟杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (streth)
/**
 *  拉伸图片
 */
+ (UIImage *)strethImageWith:(NSString *)imageName;
/**
 *  去掉导航栏和tabbar黑线的图片
 */
+ ( UIImage *)imageWithColor:( UIColor  *)color size:( CGSize )size;
- (UIImage *)scaleToSize:(CGSize)size;
//指定宽度等比压缩图片
+ (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
//指定高度等比压缩图片
+ (UIImage *)imageCompressForHeight:(UIImage *)sourceImage targetHeight:(CGFloat)defineHeight;
//等比例压缩图片
+ (UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;
+ (CGSize )sizeCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

@end

//
//  NSString+LWTool.h
//  JDQRCode
//
//  Created by 李伟杰 on 2018/6/26.
//  Copyright © 2018年 李伟杰. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LWTool)
//生成二维码
+ (UIImage *)createQRcodWithUrl:(NSString *)url Width:(CGFloat)width;
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size;

//生成动态字典
+ (NSMutableDictionary *)getDicWithValueArr:(NSArray *)valueArr keyArr:(NSArray *)keyArr;

@end

//
//  NSString+LWTool.m
//  JDQRCode
//
//  Created by 李伟杰 on 2018/6/26.
//  Copyright © 2018年 李伟杰. All rights reserved.
//

#import "NSString+LWTool.h"
#import <CommonCrypto/CommonDigest.h>
#import <sys/utsname.h>

@implementation NSString (LWTool)

+ (UIImage *)createQRcodWithUrl:(NSString *)url Width:(CGFloat)width {
    // 1.创建过滤器

    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];

    // 2.恢复默认

    [filter setDefaults];

    // 3.给过滤器添加数据(正则表达式/账号和密码)

    //    NSString *dataString = @"http://www.520it.com";

    NSData *data = [url dataUsingEncoding:NSUTF8StringEncoding];

    [filter setValue:data forKeyPath:@"inputMessage"];

    // 4.获取输出的二维码

    CIImage *outputImage = [filter outputImage];

    // 5.将CIImage转换成UIImage，并放大显示

//    self.QRcodeImage.image = [self createNonInterpolatedUIImageFormCIImage:outputImage withSize:115];
    return [NSString createNonInterpolatedUIImageFormCIImage:outputImage withSize:width];
}

/**
 * 根据CIImage生成指定大小的UIImage
 *
 * @param image CIImage
 * @param size 图片宽度
 */

+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {

    CGRect extent = CGRectIntegral(image.extent);

    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));

    // 1.创建bitmap;

    size_t width = CGRectGetWidth(extent) * scale;

    size_t height = CGRectGetHeight(extent) * scale;

    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();

    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);

    CIContext *context = [CIContext contextWithOptions:nil];

    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];

    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);

    CGContextScaleCTM(bitmapRef, scale, scale);

    CGContextDrawImage(bitmapRef, extent, bitmapImage);

    // 2.保存bitmap到图片

    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);

    CGContextRelease(bitmapRef);

    CGImageRelease(bitmapImage);

    return [UIImage imageWithCGImage:scaledImage];
}

//生成动态字典
+ (NSMutableDictionary *)getDicWithValueArr:(NSArray *)valueArr keyArr:(NSArray *)keyArr {
    NSMutableDictionary *data = [NSMutableDictionary dictionary];
    [valueArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [data setValue:obj forKey:keyArr[idx]];
    }];

    return data;
}


@end

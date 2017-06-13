//
//  UIImage+SWExtension.h
//  CatShow
//
//  Created by Timmy on 2017/6/13.
//  Copyright © 2017年 ysw.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SWExtension)

/**
 生成一张高斯模糊的图片

 @param image 原图
 @param blur 模糊程度（0-1）
 @return 高斯模糊图片
 */
+(UIImage *)blurImage:(UIImage *)image blur:(CGFloat)blur;


/**
 根据颜色生成一张图片

 @param color 颜色
 @param size 图片大小
 @return 生成的图片
 */
+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;


/**
 生成圆角图片

 @param originImage 原始图片
 @param borderColor 边框颜色
 @param borderWidth 边框宽度
 @return 切圆角后的图片
 */
+(UIImage *)circleImage:(UIImage *)originImage borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;
@end

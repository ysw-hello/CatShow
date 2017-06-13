//
//  UIImage+SWExtension.m
//  CatShow
//
//  Created by Timmy on 2017/6/13.
//  Copyright © 2017年 ysw.com. All rights reserved.
//

#import "UIImage+SWExtension.h"
#import <Accelerate/Accelerate.h>


@implementation UIImage (SWExtension)

+(UIImage *)blurImage:(UIImage *)image blur:(CGFloat)blur{
    
    //模糊度边界
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef imgRef = image.CGImage;
    vImage_Buffer inBuffer,outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    //从CGImage中获取数据
    CGDataProviderRef inProvideer = CGImageGetDataProvider(imgRef);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvideer);
    
    //设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(imgRef);
    inBuffer.height = CGImageGetHeight(imgRef);
    inBuffer.rowBytes = CGImageGetBytesPerRow(imgRef);
    inBuffer.data = (void *)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(imgRef) * CGImageGetHeight(imgRef));
    
    if (pixelBuffer == NULL) {
        NSLog(@"No pixelBuffer");
    }
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(imgRef);
    outBuffer.height = CGImageGetHeight(imgRef);
    outBuffer.rowBytes = CGImageGetBytesPerRow(imgRef);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                       &outBuffer,
                                       NULL,
                                       0,
                                       0,
                                       boxSize,
                                       boxSize,
                                       NULL,
                                       kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"error from convolution %ld",error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef contextRef = CGBitmapContextCreate(outBuffer.data,
                                                    outBuffer.width,
                                                    outBuffer.height,
                                                    8,
                                                    outBuffer.rowBytes,
                                                    colorSpace,
                                                    kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage(contextRef);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGImageRelease(imageRef);
    
    return returnImage;
}

+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size{
    if (color && size.width > 0 && size.height > 0) {
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
    return nil;
}

+(UIImage *)circleImage:(UIImage *)originImage borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    //外圆的尺寸
    CGFloat imageWidth = originImage.size.width;
    
    //内圆的尺寸
    CGFloat ovalWidth = imageWidth - 2 * borderWidth;
    
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(originImage.size, NO, 0);
    
    //画一个大的圆形
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, imageWidth, imageWidth)];
    
    [borderColor set];
    
    [path fill];
    
    //设置裁剪区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWidth, borderWidth, ovalWidth, ovalWidth)];
    [clipPath addClip];
    
    //绘制图片
    [originImage drawAtPoint:CGPointMake(borderWidth, borderWidth)];
    
    //从上下文获取图片
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return resultImage;

}

@end

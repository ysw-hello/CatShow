//
//  UIViewController+SWExtension.h
//  CatShow
//
//  Created by Timmy on 2017/6/13.
//  Copyright © 2017年 ysw.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SWExtension)

/**
 Gif 加载状态
 */
@property (nonatomic, weak) UIImageView *gifView;


/**
 显示Gif加载动画

 @param images gif图片数组，不传的话默认是自带的
 @param view 显示在哪个View上，默认为self.view
 */
-(void)showGifLoading:(NSArray *)images inView:(UIView *)view;


/**
 取消Gif加载动画
 */
-(void)hideGifLoading;


/**
 判断数组是否为空
 */
-(BOOL)isNotEmpty:(NSArray *)array;


@end

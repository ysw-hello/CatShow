//
//  UIViewController+SWHUD.h
//  CatShow
//
//  Created by Timmy on 2017/6/13.
//  Copyright © 2017年 ysw.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBProgressHUD;

@interface UIViewController (SWHUD)

@property (nonatomic, weak, readonly) MBProgressHUD *hud;


/**
 提示信息

 @param view 显示在哪个View
 @param hint 提示语
 */
-(void)showHudInView:(UIView *)view hint:(NSString *)hint;
-(void)showHudInView:(UIView *)view hint:(NSString *)hint yOffset:(float)yOffset;


/**
 隐藏hud
 */
-(void)hideHud;


/**
 提示信息 mode：MBProgressHUDModeText

 @param hint 提示语
 */
-(void)showHint:(NSString *)hint;
-(void)showHint:(NSString *)hint inView:(UIView *)view;


/**
 提示语下移

 @param hint 提示语
 @param yOffset 下移的距离
 */
-(void)showHint:(NSString *)hint yOffset:(float)yOffset;

@end

//
//  UIViewController+SWHUD.m
//  CatShow
//
//  Created by Timmy on 2017/6/13.
//  Copyright © 2017年 ysw.com. All rights reserved.
//

#import "UIViewController+SWHUD.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>

static const void *HudKey = &HudKey;

@implementation UIViewController (SWHUD)

#pragma mark - 对象关联动态绑定hud属性
-(MBProgressHUD *)hud{
    return objc_getAssociatedObject(self, HudKey);
}

-(void)setHud:(MBProgressHUD *)hud{
    objc_setAssociatedObject(self, HudKey, hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - 方法实现

-(void)showHudInView:(UIView *)view hint:(NSString *)hint{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.labelText = hint;
    [view addSubview:hud];
    [hud show:YES];
    [self setHud:hud];
}

-(void)showHudInView:(UIView *)view hint:(NSString *)hint yOffset:(float)yOffset{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.labelText = hint;
    HUD.margin = 10.f;
    HUD.yOffset += yOffset;
    [view addSubview:HUD];
    [HUD show:YES];
    [self setHud:HUD];

}

-(void)showHint:(NSString *)hint{
    UIView *view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2.f];
}

-(void)showHint:(NSString *)hint inView:(UIView *)view{
    //显示提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [view addSubview:hud];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud show:YES];
    [hud hide:YES afterDelay:2];

}

-(void)showHint:(NSString *)hint yOffset:(float)yOffset{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication] keyWindow];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.yOffset += yOffset;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

- (void)hideHud{
    [[self hud] hide:YES];
}

@end

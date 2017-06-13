//
//  SWTopWindow.m
//  CatShow
//
//  Created by Timmy on 2017/6/12.
//  Copyright © 2017年 ysw.com. All rights reserved.
//

#import "SWTopWindow.h"

@implementation SWTopWindow

static UIButton *btn_;

+(void)initialize{
    UIButton *btn = [[UIButton alloc] initWithFrame:[UIApplication sharedApplication].statusBarFrame];
    [btn addTarget:self action:@selector(windowClick) forControlEvents:UIControlEventTouchUpInside];
    [[self statusBarView] addSubview:btn];
    btn_ = btn;
}

+(void)show{
    btn_.hidden = NO;
}

+(void)hide{
    btn_.hidden = YES;
}


/**
 获取当前状态栏
 */
+(UIView *)statusBarView{
    UIView *statusBar = nil;
    NSData *data = [NSData dataWithBytes:(unsigned char []){0x73, 0x74, 0x61, 0x74, 0x75, 0x73, 0x42, 0x61, 0x72} length:9];
    NSString *key = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    id object = [UIApplication sharedApplication];
    if ([object respondsToSelector:NSSelectorFromString(key)]) {
        statusBar = [object valueForKey:key];
    }
    return statusBar;
}

/**
 监听窗口点击
 */
+(void)windowClick{
    NSLog(@"点击了最顶部tabbar");
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}

+(void)searchScrollViewInView:(UIView *)superView{
    for (UIScrollView *subView in superView.subviews) {
        //如果是scrollView，滚动到最顶部
        if ([subView isKindOfClass:NSClassFromString(@"UIScrollView")] && subView.isShowingOnKeyWindow) {
            CGPoint offset = subView.contentOffset;
            offset.y = -subView.contentInset.top;
            [subView setContentOffset:offset animated:YES];
        }
        //继续查找子控件
        [self searchScrollViewInView:subView];
    }
    
}

@end

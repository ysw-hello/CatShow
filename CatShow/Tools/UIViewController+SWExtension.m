//
//  UIViewController+SWExtension.m
//  CatShow
//
//  Created by Timmy on 2017/6/13.
//  Copyright © 2017年 ysw.com. All rights reserved.
//

#import "UIViewController+SWExtension.h"
#import "UIImageView+SWExtension.h"
#import <objc/runtime.h>

static const void *GifKey = &GifKey;

@implementation UIViewController (SWExtension)

-(UIImageView *)gifView{
    return objc_getAssociatedObject(self, GifKey);
}

-(void)setGifView:(UIImageView *)gifView{
    objc_setAssociatedObject(self, GifKey, gifView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)showGifLoading:(NSArray *)images inView:(UIView *)view{
    if (images.count < 2) {
        images = @[[UIImage imageNamed:@"hold1_60x72"], [UIImage imageNamed:@"hold2_60x72"], [UIImage imageNamed:@"hold3_60x72"]];
    }
    UIImageView *gifView = [[UIImageView alloc] init];
    if (!view) {
        view = self.view;
    }
    [view addSubview:gifView];
    
    [gifView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.equalTo(@60);
        make.height.equalTo(@70);
    }];
    self.gifView = gifView;
    [gifView playGifWithImagaArr:images];
    
}

-(void)hideGifLoading{
    [self.gifView stopGifAnimation];
    self.gifView = nil;
}

-(BOOL)isNotEmpty:(NSArray *)array{
    if ([array isKindOfClass:[NSArray class]] && array.count) {
        return  YES;
    }
    return NO;
}

@end

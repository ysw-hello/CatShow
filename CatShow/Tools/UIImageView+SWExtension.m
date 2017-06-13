//
//  UIImageView+SWExtension.m
//  CatShow
//
//  Created by Timmy on 2017/6/13.
//  Copyright © 2017年 ysw.com. All rights reserved.
//

#import "UIImageView+SWExtension.h"

@implementation UIImageView (SWExtension)

-(void)playGifWithImagaArr:(NSArray *)images{
    if (images.count < 2) {
        return;
    }
    self.animationImages = images;
    self.animationDuration = 0.5;
    self.animationRepeatCount = 0;//无限循环
    
    [self startAnimating];
}

-(void)stopGifAnimation{
    if (self.isAnimating) {
        [self stopAnimating];
    }
    [self removeFromSuperview];
}

@end

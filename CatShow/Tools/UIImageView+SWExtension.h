//
//  UIImageView+SWExtension.h
//  CatShow
//
//  Created by Timmy on 2017/6/13.
//  Copyright © 2017年 ysw.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (SWExtension)

//播放Gif
-(void)playGifWithImagaArr:(NSArray *)images;

//停止动画
-(void)stopGifAnimation;


@end

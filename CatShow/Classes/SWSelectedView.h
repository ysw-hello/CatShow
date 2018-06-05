//
//  SWSelectedView.h
//  CatShow
//
//  Created by Timmy on 2017/6/14.
//  Copyright © 2017年 ysw.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HomeType) {
    kHomeTypeHot, //热门
    KHomeTypeNew, //最新
    kHomeTypeCare,//关注
};

typedef void(^SelectedBlock)(HomeType type);

@interface SWSelectedView : UIView

/**
 选择后的回调
 */
@property (nonatomic, copy) SelectedBlock block;

/**
 设置滑动选中的按钮
 */
@property (nonatomic, assign) HomeType selectedType;

@property (nonatomic, weak) UIView *underLine;


@end

//
//  SWThirdLoginView.h
//  CatShow
//
//  Created by Timmy on 2017/6/12.
//  Copyright © 2017年 ysw.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LoginType) {
    kLoginTypeSina,
    kLoginTypeQQ,
    kLoginWechat,
};

typedef void(^ClickLoginHandler)(LoginType type);

@interface SWThirdLoginView : UIView


/**
 第三方登录按钮的点击
 */
@property (nonatomic, copy) ClickLoginHandler block;

@end

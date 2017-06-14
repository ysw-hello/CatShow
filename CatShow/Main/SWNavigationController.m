//
//  SWNavigationController.m
//  CatShow
//
//  Created by Timmy on 2017/6/12.
//  Copyright © 2017年 ysw.com. All rights reserved.
//

#import "SWNavigationController.h"

@interface SWNavigationController ()

@end

@implementation SWNavigationController

+(void)initialize{
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navBar_bg_414x70"] forBarMetrics:UIBarMetricsDefault];
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count) {
        //隐藏导航栏
        viewController.hidesBottomBarWhenPushed = YES;
        
        //自定义返回按钮
        UIButton *btn = [[UIButton alloc] init];
        [btn setImage:[UIImage imageNamed:@"back_9x16"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [btn sizeToFit];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        
        //如果自定义返回按钮，滑动pop手势可能失效，需要添加如下代码
        __weak typeof(viewController) weakSelf = viewController;
        self.interactivePopGestureRecognizer.delegate = (id)weakSelf;
    }
    [super pushViewController:viewController animated:animated];
}

-(void)back{
    //判断两种情况：push 和 present
    if ( (self.presentedViewController || self.presentingViewController) && self.childViewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self popViewControllerAnimated:YES];
    }
}

@end

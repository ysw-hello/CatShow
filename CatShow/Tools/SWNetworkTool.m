//
//  SWNetworkTool.m
//  CatShow
//
//  Created by Timmy on 2017/6/13.
//  Copyright © 2017年 ysw.com. All rights reserved.
//

#import "SWNetworkTool.h"

@implementation SWNetworkTool

static SWNetworkTool *_manager;

+(instancetype)sharedNetworkTool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [SWNetworkTool manager];
        //设置超时时间
        _manager.requestSerializer.timeoutInterval = 5.f;
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",@"text/xml",@"text/plain", nil];
    });
    return _manager;
}

+(NetworkStates)getNetworkStates{
    NSArray *subViews = [[[[UIApplication sharedApplication] valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    //保存网络状态
    NetworkStates states = NetworkStatesNone;
    
    for (id child in subViews) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态码
            int networkType = [[child valueForKeyPath:@"dataNetworkType"] intValue];
            
            switch (networkType) {
                case 0:
                    states = NetworkStatesNone;
                    break;
                    
                case 1:
                    states = NetworkStates2G;
                    break;
                    
                case 2:
                    states = NetworkStates3G;
                    break;
                    
                case 3:
                    states = NetworkStates4G;
                    break;
                    
                default:
                    break;
            }
        }
    }
    return states;
}


@end

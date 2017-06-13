//
//  SWNetworkTool.h
//  CatShow
//
//  Created by Timmy on 2017/6/13.
//  Copyright © 2017年 ysw.com. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef NS_ENUM(NSUInteger, NetworkStates) {
    NetworkStatesNone, //没有网络
    NetworkStates2G, //2G
    NetworkStates3G, //3G
    NetworkStates4G, //4G
    NetworkStatesWIFI //WIFI
};

@interface SWNetworkTool : AFHTTPSessionManager

+(instancetype)sharedNetworkTool;

//判断网络类型
+(NetworkStates)getNetworkStates;

@end

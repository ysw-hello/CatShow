//
//  MJRefreshGifHeader+SWExtension.m
//  CatShow
//
//  Created by Timmy on 2017/6/13.
//  Copyright © 2017年 ysw.com. All rights reserved.
//

#import "MJRefreshGifHeader+SWExtension.h"

@implementation MJRefreshGifHeader (SWExtension)

-(instancetype)init{
    if (self = [super init]) {
        self.lastUpdatedTimeLabel.hidden = YES;
        self.stateLabel.hidden = YES;
        
        NSArray *images = @[[UIImage imageNamed:@"reflesh1_60x55"], [UIImage imageNamed:@"reflesh2_60x55"], [UIImage imageNamed:@"reflesh3_60x55"]];
        
        [self setImages:images forState:MJRefreshStateRefreshing];
        [self setImages:images forState:MJRefreshStatePulling];
        [self setImages:images forState:MJRefreshStateIdle];
    }
    return self;
}

@end

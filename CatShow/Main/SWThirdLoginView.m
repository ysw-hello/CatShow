//
//  SWThirdLoginView.m
//  CatShow
//
//  Created by Timmy on 2017/6/12.
//  Copyright © 2017年 ysw.com. All rights reserved.
//

#import "SWThirdLoginView.h"

@implementation SWThirdLoginView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(void)setup{
    UIImageView *sina = [self createImageView:@"wbLoginicon_60x60" tag:kLoginTypeSina];
    UIImageView *qq = [self createImageView:@"qqloginicon_60x60" tag:kLoginTypeQQ];
    UIImageView *wechat = [self createImageView:@"wxloginicon_60x60" tag:kLoginWechat];
    
    [self addSubview:sina];
    [self addSubview:qq];
    [self addSubview:wechat];
    
    [sina mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.equalTo(@60);
    }];
    
    [qq mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sina);
        make.right.equalTo(sina.mas_left).offset(-20);
        make.size.equalTo(sina);
    }];
    
    [wechat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sina);
        make.left.equalTo(sina.mas_right).offset(20);
        make.size.equalTo(sina);
    }];
}

-(UIImageView *)createImageView:(NSString *)imageName tag:(NSUInteger)tag{
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.image = [UIImage imageNamed:imageName];
    imageV.tag = tag;
    imageV.userInteractionEnabled = YES;
    [imageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)]];
    return imageV;
}

-(void)click:(UITapGestureRecognizer *)tapGes{
    if (self.block) {
        self.block(tapGes.view.tag);
    }
}

@end

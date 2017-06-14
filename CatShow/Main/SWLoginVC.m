//
//  SWLoginVC.m
//  CatShow
//
//  Created by Timmy on 2017/6/12.
//  Copyright © 2017年 ysw.com. All rights reserved.
//

#import "SWLoginVC.h"
#import "SWThirdLoginView.h"
#import "SWMainVC.h"

@interface SWLoginVC ()

/**
 video player
 */
@property (nonatomic, strong) IJKFFMoviePlayerController *player;

/**
 第三方登录view
 */
@property (nonatomic, weak) SWThirdLoginView *thirdLoginView;

/**
 快速登录
 */
@property(nonatomic, weak) UIButton *quickBtn;

/**
 封面图片
 */
@property (nonatomic, weak)UIImageView *coverview;

@end

@implementation SWLoginVC

#pragma mark - lazy load
-(IJKFFMoviePlayerController *)player{
    if (!_player) {
        //随机播放一组视频
        NSString *path = arc4random_uniform(10) % 2 ? @"login_video" : @"loginmovie";
        IJKFFMoviePlayerController *player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:[[NSBundle mainBundle] pathForResource:path ofType:@"mp4"] withOptions:[IJKFFOptions optionsByDefault]];
        
        player.view.frame = self.view.bounds;
        player.scalingMode = IJKMPMovieScalingModeAspectFill;
        
        [self.view addSubview:player.view];
        player.shouldAutoplay = NO;
        [player prepareToPlay];
        
        _player = player;
    }
    return _player;
}

-(SWThirdLoginView *)thirdLoginView{
    if (!_thirdLoginView) {
        SWThirdLoginView *thirdView = [[SWThirdLoginView alloc] initWithFrame:CGRectMake(0, 0, 400, 200)];
        [thirdView setBlock:^(LoginType type){
            [self showHint:@"目前不支持第三方登录"];
//            [self loginSuccess];
        }];
        thirdView.hidden = YES;
        [self.view addSubview:thirdView];
        _thirdLoginView = thirdView;
    }
    return _thirdLoginView;
}

-(UIButton *)quickBtn{
    if (!_quickBtn) {
        UIButton *button = [[UIButton alloc] init];
        button.backgroundColor = [UIColor clearColor];
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor whiteColor].CGColor;
        
        [button setTitle:@"Timmy快速通道" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(loginSuccess) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
        button.hidden = YES;
        _quickBtn = button;
    }
    return _quickBtn;
}

-(UIImageView *)coverview{
    if (!_coverview) {
        UIImageView *coverImageV = [[UIImageView alloc] initWithFrame:self.view.bounds];
        coverImageV.image = [UIImage imageNamed:@"LaunchImage"];
        [self.player.view addSubview:coverImageV];
        _coverview = coverImageV;
    }
    return _coverview;
}

#pragma mark - VC life circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor orangeColor];
    [self setup];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.player shutdown];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [self.player.view removeFromSuperview];
    self.player = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - private methods
-(void)loginSuccess{
    [self showHint:@"登录成功"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self presentViewController:[[SWMainVC alloc] init] animated:NO completion:^{
            [self.player stop];
            [self.player.view removeFromSuperview];
            self.player = nil;
        }];
    });
}

-(void)setup{
    [self initObserver];
    
    self.coverview.hidden = NO;
    
    [self.quickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@40);
        make.right.equalTo(@-40);
        make.bottom.equalTo(@-60);
        make.height.equalTo(@40);
    }];
    
    [self.thirdLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@60);
        make.bottom.equalTo(self.quickBtn.mas_top).offset(-40);
    }];
}

-(void)initObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinish) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:nil];
}

-(void)didFinish{
    //播放完之后，继续重播
    [self.player play];
}
-(void)stateDidChange{
    if ((self.player.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        if (!self.player.isPlaying) {
            self.coverview.frame = self.view.bounds;
            [self.view insertSubview:self.coverview atIndex:0];
            [self.player play];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.thirdLoginView.hidden = NO;
                self.quickBtn.hidden = NO;
            });
        }
    }
}

@end

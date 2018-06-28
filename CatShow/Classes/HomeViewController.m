//
//  HomeViewController.m
//  CatShow
//
//  Created by Timmy on 2017/6/14.
//  Copyright © 2017年 ysw.com. All rights reserved.
//

#import "HomeViewController.h"
#import "SWSelectedView.h"

#import "SWWebBaseVC.h"

#import "SWHotViewController.h"
#import "SWNewStarViewController.h"
#import "SWCareViewController.h"


@interface HomeViewController ()<UIScrollViewDelegate>

/**
 顶部选择视图
 */
@property (nonatomic, weak) SWSelectedView *selectedView;

/**
 最底层scrollView
 */
@property (nonatomic, weak) UIScrollView *mainScrollView;

/**
 热播
 */
@property (nonatomic, weak) SWHotViewController *hotVC;

/**
 最新主播
 */
@property (nonatomic, weak) SWNewStarViewController *latestVC;

/**
 关注主播
 */
@property (nonatomic, weak) SWCareViewController *careVC;

@end

@implementation HomeViewController

-(void)loadView{
    UIScrollView *view = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.contentSize = CGSizeMake(SWScreenWidth * 3, 0);
    view.backgroundColor = [UIColor whiteColor];
    view.showsVerticalScrollIndicator = NO;
    view.showsHorizontalScrollIndicator = NO;
    
    view.pagingEnabled = YES;
    view.bounces = NO;
    
    view.delegate = self;
    
    CGFloat height = SWScreenHeight - 49;
    
    //添加子视图
    SWHotViewController *hot = [[SWHotViewController alloc] init];
    hot.view.frame = [UIScreen mainScreen].bounds;
    hot.view.height = height;
    [self addChildViewController:hot];
    [view addSubview:hot.view];
    _hotVC = hot;
    
    SWNewStarViewController *newStar = [[SWNewStarViewController alloc] init];
    newStar.view.frame = [UIScreen mainScreen].bounds;
    newStar.view.x = SWScreenWidth;
    newStar.view.height = height;
    [self addChildViewController:newStar];
    [view addSubview:newStar.view];
    _latestVC = newStar;
    
    SWCareViewController *care = [[SWCareViewController alloc] init];
    care.view.frame = [UIScreen mainScreen].bounds;
    care.view.x = SWScreenWidth *2;
    care.view.height = height;
    [self addChildViewController:care];
    [view addSubview:care.view];
    _careVC = care;
    
    self.view = view;
    self.mainScrollView = view;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setup];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!_selectedView) {
        [self setupTopMenu];
    }
}

-(void)setup{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search_15x14"] style:UIBarButtonItemStyleDone target:self action:@selector(search)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"head_crown_24x24"] style:UIBarButtonItemStyleDone target:self action:@selector(rankCrown)];
    [self setupTopMenu];

}
//搜索界面
-(void)search{
    [self showInfo:@"点击了搜索按钮"];
}
//排行界面
-(void)rankCrown{
    SWWebBaseVC *web = [[SWWebBaseVC alloc] initWithUrlStr:@"http://live.9158.com/Rank/WeekRank?Random=10"];
    web.navigationItem.title = @"排行";
    [_selectedView removeFromSuperview];
    _selectedView = nil;
    [self.navigationController pushViewController:web animated:YES];

}
-(void)setupTopMenu{
    //设置顶部选择视图
    SWSelectedView *selectedView = [[SWSelectedView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    selectedView.x = 45;
    selectedView.width = SWScreenWidth - 45*2;
    
    __weak typeof(self) weakSelf = self;
    [selectedView setBlock:^(HomeType type){
        [weakSelf.mainScrollView setContentOffset:CGPointMake(type * SWScreenWidth, 0) animated:YES];
    }];
    [self.navigationController.navigationBar addSubview:selectedView];
    _selectedView = selectedView;
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat page = scrollView.contentOffset.x / SWScreenWidth;
    CGFloat offsetX = page * (self.selectedView.width * 0.5 - Home_Seleted_Item_W * 0.5 -15);
    self.selectedView.underLine.x = 15 + offsetX;
    if (page == 1) {
        self.selectedView.underLine.x = offsetX + 10;
    }else if (page > 1){
        self.selectedView.underLine.x = offsetX + 5;
    }
    self.selectedView.selectedType = (int)(page + 0.5);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

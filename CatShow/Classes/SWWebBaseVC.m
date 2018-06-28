//
//  SWWebBaseVC.m
//  CatShow
//
//  Created by Timmy on 2017/6/14.
//  Copyright © 2017年 ysw.com. All rights reserved.
//

#import "SWWebBaseVC.h"

@interface SWWebBaseVC ()

/** webView */
@property (nonatomic, weak) UIWebView *webView;


@end

@implementation SWWebBaseVC

- (UIWebView *)webView
{
    if (!_webView) {
        UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:web];
        _webView = web;
    }
    return _webView;
}

- (instancetype)initWithUrlStr:(NSString *)url
{
    if (self = [self init]) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  SWMainVC.m
//  CatShow
//
//  Created by Timmy on 2017/6/12.
//  Copyright © 2017年 ysw.com. All rights reserved.
//

#import "SWMainVC.h"

#import "HomeViewController.h"
#import "ShowTimeViewController.h"
#import "ProfileViewController.h"

#import "SWNavigationController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIDevice+SWExtension.h"


@interface SWMainVC ()<UITabBarControllerDelegate>

@end

@implementation SWMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
    [self setup];
}

-(void)setup{
    [self addChildVC:[[HomeViewController alloc] init] imageNamed:@"toolbar_home" itemTitle:@"广场"];
    [self addChildVC:[[ShowTimeViewController alloc] init] imageNamed:@"toolbar_live" itemTitle:nil];
    [self addChildVC:[[ProfileViewController alloc] init] imageNamed:@"toolbar_me" itemTitle:@"我的"];
}

-(void)addChildVC:(UIViewController *)childVC imageNamed:(NSString *)imageName itemTitle:(NSString *)itemTitle{
    SWNavigationController *nav = [[SWNavigationController alloc] initWithRootViewController:childVC];
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.title = itemTitle;
     childVC.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_sel",imageName]];
    
    //设置图片居中，这里需要注意top和bottom绝对值必须一样大
    childVC.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    //设置导航栏透明
    if ([childVC isKindOfClass:[ProfileViewController class]]) {
        [nav.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        nav.navigationBar.shadowImage = [[UIImage alloc] init];
        nav.navigationBar.translucent = YES;
    }
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITabBarControllerDelegate
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    if ([tabBarController.childViewControllers indexOfObject:viewController] == tabBarController.childViewControllers.count-2) {
        //第二个tabbarItem - showTimeViewController
        
        //判断是否是模拟器
        if([[UIDevice deviceVersion] isEqualToString:@"iPhone Simulator"]){
            [self showInfo:@"请用真机进行测试，此模块不支持模拟器测试"];
            return NO;
        }
        
        //判断是否有摄像头
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self showInfo:@"您的设备没有摄像头或者相关的驱动，不能进行直播"];
            return NO;
        }
        
        //判断是否有摄像头权限
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusDenied || authStatus == AVAuthorizationStatusRestricted) {
            [self showInfo:@"App需要访问您的摄像头。\n请启用摄像头--设置/隐私/相机"];
            return NO;
        }
        
        //开启麦克风权限
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted){
                if (granted) {
                    return YES;
                }else{
                    [self showInfo:@"App需要访问您的麦克风。\n请启用麦克风--设置/隐私/麦克风"];
                    return NO;
                }
                
            }];
        }
        
        ShowTimeViewController *showTimeVC = [[[NSBundle mainBundle] loadNibNamed:@"ShowTimeViewController" owner:self options:nil] lastObject];
        [self presentViewController:showTimeVC animated:YES completion:nil];
        
        return NO;
    }
    
    
    return YES;

}

@end

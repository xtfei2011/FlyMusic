//
//  TFNavigationController.m
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/14.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFNavigationController.h"
#import "TFAudioPlayerController.h"
#import "UINavigationBar+TFExtension.h"

@interface TFNavigationController ()

@end

@implementation TFNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [UIColor xtf_setDefaultNavBarBarTintColor:TFCommonTitleColor];
    // 设置导航栏所有按钮的默认颜色
    [UIColor xtf_setDefaultNavBarTintColor:[UIColor whiteColor]];
    // 设置导航栏标题默认颜色
    [UIColor xtf_setDefaultNavBarTitleColor:[UIColor whiteColor]];
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:18], NSFontAttributeName, nil]];
}

/*** 重写push方法：拦截所有push进来的子控制器 ***/
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"cm2_topbar_icn_playing" highImage:@"cm2_topbar_icn_playing" target:self action:@selector(playButtonClick)];
    
    if (self.childViewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.view.backgroundColor = TFCommonBgColor;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"cm2_act_view_btn_back" highImage:@"cm2_act_view_btn_back_prs" target:self action:@selector(back)];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

/*** 回到播放页面 ***/
- (void)playButtonClick
{
    TFLog(@"---->播放器");
    [self presentViewController:[TFAudioPlayerController sharePlayerViewController] animated:YES completion:nil];
}
@end

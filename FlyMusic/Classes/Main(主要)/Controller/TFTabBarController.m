//
//  TFTabBarController.m
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/14.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFTabBarController.h"
#import "TFNavigationController.h"
#import "TFRecommendController.h"
#import "TFClassifyController.h"
#import "TFSongListController.h"
#import "TFSingerController.h"
#import "TFInstallController.h"

@interface TFTabBarController ()

@end

@implementation TFTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**** 设置所有UITabBarItem的文字属性 ****/
    [self setupItemTitleTextAttributes];
    
    /**** 添加子控制器 ****/
    [self setupChildViewControllers];
}

/**
 *  设置所有UITabBarItem的文字属性
 */
- (void)setupItemTitleTextAttributes
{
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = normalAttrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = TFCommonTitleColor;
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

/**
 *  添加子控制器
 */
- (void)setupChildViewControllers
{
    [self setupChildViewController:[[TFRecommendController alloc] init] title:@"推荐" image:@"recommend" selectedImage:@"recommend_high"];
    [self setupChildViewController:[[TFClassifyController alloc] init] title:@"榜单" image:@"classify" selectedImage:@"classify_high"];
    [self setupChildViewController:[[TFSongListController alloc] init] title:@"歌单" image:@"song_list" selectedImage:@"song_list_high"];
    [self setupChildViewController:[[TFSingerController alloc] init] title:@"歌手" image:@"singer" selectedImage:@"singer_high"];
    [self setupChildViewController:[[TFInstallController alloc] init] title:@"设置" image:@"set" selectedImage:@"set_high"];
}

/**
 *  初始化一个子控制器
 *
 *  @param viewController            子控制器
 *  @param title                     标题
 *  @param image                     图标
 *  @param selectedImage             选中的图标
 */
- (void)setupChildViewController:(UIViewController *)viewController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    viewController.title = title;
    viewController.tabBarItem.image = [UIImage imageNamed:image];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.view.backgroundColor = TFCommonBgColor;
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    TFNavigationController *nav = [[TFNavigationController alloc] initWithRootViewController:viewController];
    // 添加为子控制器
    [self addChildViewController:nav];
}
@end

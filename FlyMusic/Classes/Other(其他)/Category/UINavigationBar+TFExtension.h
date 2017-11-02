//
//  UINavigationBar+TFExtension.h
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/25.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - UINavigationBar
@interface UINavigationBar (TFExtension)<UINavigationBarDelegate>
/*** 设置导航栏所有BarButtonItem的透明度 ***/
- (void)xtf_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator;

/*** 设置导航栏在垂直方向上平移多少距离 ***/
- (void)xtf_setTranslationY:(CGFloat)translationY;

/*** 获取当前导航栏在垂直方向上偏移了多少 ***/
- (CGFloat)xtf_getTranslationY;
@end


#pragma mark - UIColor
@interface UIColor (TFExtension)

/*** 设置UINavigationBar的TintColor ***/
+ (void)xtf_setDefaultNavBarBarTintColor:(UIColor *)color;

/*** 设置UINavigationBar的默认背景图 ***/
+ (void)xtf_setDefaultNavBarBackgroundImage:(UIImage *)image;

/*** set default tintColor of UINavigationBar ***/
+ (void)xtf_setDefaultNavBarTintColor:(UIColor *)color;

/*** set default titleColor of UINavigationBar ***/
+ (void)xtf_setDefaultNavBarTitleColor:(UIColor *)color;

/*** set default statusBarStyle of UIStatusBar ***/
+ (void)xtf_setDefaultStatusBarStyle:(UIStatusBarStyle)style;

/*** set default shadowImage isHidden of UINavigationBar ***/
+ (void)xtf_setDefaultNavBarShadowImageHidden:(BOOL)hidden;

@end


#pragma mark - UIViewController
@interface UIViewController (TFExtension)

/*** record current ViewController navigationBar backgroundImage ****/
- (void)xtf_setNavBarBackgroundImage:(UIImage *)image;
- (UIImage *)xtf_navBarBackgroundImage;

/*** record current ViewController navigationBar barTintColor ***/
- (void)xtf_setNavBarBarTintColor:(UIColor *)color;
- (UIColor *)xtf_navBarBarTintColor;

/*** record current ViewController navigationBar backgroundAlpha ***/
- (void)xtf_setNavBarBackgroundAlpha:(CGFloat)alpha;
- (CGFloat)xtf_navBarBackgroundAlpha;

/*** record current ViewController navigationBar tintColor ***/
- (void)xtf_setNavBarTintColor:(UIColor *)color;
- (UIColor *)xtf_navBarTintColor;

/*** record current ViewController titleColor ***/
- (void)xtf_setNavBarTitleColor:(UIColor *)color;
- (UIColor *)xtf_navBarTitleColor;

/*** record current ViewController statusBarStyle ***/
- (void)xtf_setStatusBarStyle:(UIStatusBarStyle)style;
- (UIStatusBarStyle)xtf_statusBarStyle;

/*** record current ViewController navigationBar shadowImage hidden ***/
- (void)xtf_setNavBarShadowImageHidden:(BOOL)hidden;
- (BOOL)xtf_navBarShadowImageHidden;

/*** record current ViewController custom navigationBar ***/
- (void)xtf_setCustomNavBar:(UINavigationBar *)navBar;

@end

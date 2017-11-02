//
//  TFProgressHUD.h
//  多酷音乐
//
//  Created by 谢腾飞 on 2016/12/16.
//  Copyright © 2016年 谢腾飞. All rights reserved.
//

#import "MBProgressHUD.h"

typedef NS_ENUM(NSInteger, TFProgressHUDStatus) {
    
    /*** 成功 ***/
    TFProgressHUDSucceed,
    /*** 失败 ***/
    TFProgressHUDError,
    /*** 提示 ***/
    TFProgressHUDPrompt,
    /*** 等待 ***/
    TFProgressHUDWait
};
@interface TFProgressHUD : MBProgressHUD
/*** 返回一个 HUD 的单例 ***/
+ (instancetype)sharedHUD;

/*** 添加一个 HUD ***/
+ (void)showStatus:(TFProgressHUDStatus)status text:(NSString *)text;

#pragma mark - 建议使用的方法
/*** 只显示文字的 HUD ***/
+ (void)showMessage:(NSString *)text;

/*** 提示`文本`的 HUD ***/
+ (void)showInfoMsg:(NSString *)text;

/*** 提示`失败`的 HUD ***/
+ (void)showFailure:(NSString *)text;

/*** 提示`成功`的 HUD ***/
+ (void)showSuccess:(NSString *)text;

/*** 提示`等待`的 HUD, 需要手动关闭 ***/
+ (void)showLoading:(NSString *)text;

/*** 手动隐藏 HUD ***/
+ (void)dismiss;
@end

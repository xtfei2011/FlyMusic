//
//  TFProgressHUD.m
//  多酷音乐
//
//  Created by 谢腾飞 on 2016/12/16.
//  Copyright © 2016年 谢腾飞. All rights reserved.
//

#import "TFProgressHUD.h"

@implementation TFProgressHUD

+ (instancetype)sharedHUD
{
    static TFProgressHUD *hud;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        hud = [[TFProgressHUD alloc] initWithWindow:TFkeyWindowView];
    });
    return hud;
}

+ (void)showStatus:(TFProgressHUDStatus)status text:(NSString *)text {
    
    TFProgressHUD *hud = [TFProgressHUD sharedHUD];
    [hud show:YES];
    [hud setLabelText:text];
    [hud setRemoveFromSuperViewOnHide:YES];
    [hud setLabelFont:[UIFont boldSystemFontOfSize:16]];
    [hud setMinSize:CGSizeMake(100, 100)];
    [TFkeyWindowView addSubview:hud];
    
    switch (status) {
            
        case TFProgressHUDSucceed: {
            
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *sucView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hud_success"]];
            hud.customView = sucView;
            [hud hide:YES afterDelay:2.0f];
        }
            break;
            
        case TFProgressHUDError: {
            
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *errView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hud_error"]];
            hud.customView = errView;
            [hud hide:YES afterDelay:2.0f];
        }
            break;
            
        case TFProgressHUDWait: {
            
            hud.mode = MBProgressHUDModeIndeterminate;
        }
            break;
            
        case TFProgressHUDPrompt: {
            
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *infoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hud_info"]];
            hud.customView = infoView;
            [hud hide:YES afterDelay:2.0f];
        }
            break;
            
        default:
            break;
    }
}

+ (void)showMessage:(NSString *)text {
    
    TFProgressHUD *hud = [TFProgressHUD sharedHUD];
    [hud show:YES];
    [hud setLabelText:text];
    [hud setMinSize:CGSizeZero];
    [hud setMode:MBProgressHUDModeText];
    [hud setRemoveFromSuperViewOnHide:YES];
    [hud setLabelFont:[UIFont boldSystemFontOfSize:16]];
    [TFkeyWindowView addSubview:hud];
    [hud hide:YES afterDelay:2.0f];
}

+ (void)showInfoMsg:(NSString *)text {
    
    [self showStatus:TFProgressHUDPrompt text:text];
}

+ (void)showFailure:(NSString *)text {
    
    [self showStatus:TFProgressHUDError text:text];
}

+ (void)showSuccess:(NSString *)text {
    
    [self showStatus:TFProgressHUDSucceed text:text];
}

+ (void)showLoading:(NSString *)text {
    
    [self showStatus:TFProgressHUDWait text:text];
}

+ (void)dismiss {
    
    [[TFProgressHUD sharedHUD] hide:YES];
}
@end

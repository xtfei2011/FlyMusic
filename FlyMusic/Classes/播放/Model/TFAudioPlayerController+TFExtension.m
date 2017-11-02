//
//  TFAudioPlayerController+TFExtension.m
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/18.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFAudioPlayerController+TFExtension.h"
#import "UIImage+TFEffects.h"

@implementation TFAudioPlayerController (TFExtension)
- (void)creatViews
{
    self.turnView = [[TFTurnView alloc] init];
    self.turnView.turnImage.image = [UIImage imageNamed:@"音乐_播放器_默认唱片头像"];
    [self.view addSubview:self.turnView];
}

- (void)progressHUDWith:(NSString *)string
{
    [TFProgressHUD showMessage:string];
}

- (void)setTurnViewFrame
{
    CGFloat turnViewH = TFMainScreen_Height - topHeight - downHeight;
    if (TFMainScreen_Height < 500) {
        self.turnView.frame = CGRectMake(0, 0, turnViewH * 0.8, turnViewH * 0.8);
    }else{
        self.turnView.frame = CGRectMake(0, 0, TFMainScreen_Width * 0.8, TFMainScreen_Width * 0.8);
    }
    self.turnView.center = CGPointMake(TFMainScreen_Width / 2, turnViewH / 2 + topHeight);
    [self.turnView setTurnViewLayoutWithFrame:self.turnView.frame];
}

- (void)setImageWith:(TFPlayMusic *)model type:(NSInteger)type
{
    [self.turnView addAnimation];
    self.underImageView.image = [UIImage imageNamed:@"newUserLoginBg"];
    
    NSString *urlStr = type ? model.objectInfo.albumImgs.img : model.albumImgs.img;
    
    [self.turnView.turnImage sd_setImageWithURL:[NSURL URLWithString:urlStr] placeholderImage:[UIImage imageNamed:@"音乐_播放器_默认唱片头像"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            self.underImageView.image = [image applyDarkEffect];
        }
    }];
}
@end

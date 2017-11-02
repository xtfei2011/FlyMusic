//
//  TFAudioPlayerController+TFExtension.h
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/18.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFAudioPlayerController.h"

@interface TFAudioPlayerController (TFExtension)
/**
 *  创建部分控件
 */
- (void)creatViews;

/**
 *  设置旋转图的Frame
 */
- (void)setTurnViewFrame;

/**
 *  设置旋转图片、模糊图片
 *
 *  @param model 当前的音乐model
 */
- (void)setImageWith:(TFPlayMusic *)model type:(NSInteger)type;

/**
 *  提示框
 *
 *  @param string 提示字符串
 */
- (void)progressHUDWith:(NSString *)string;
@end

//
//  TFAudioPlayerController.h
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/17.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "TFPlayMusic.h"
#import "TFTurnView.h"
#import "UIImage+TFExtension.h"

/*** TFAudioPlayerMode 播放模式 ***/
typedef NS_ENUM(NSInteger, TFAudioPlayerMode) {
    /**
     *  顺序播放
     */
    TFAudioPlayerModeOrderPlay,
    /**
     *  随机播放
     */
    TFAudioPlayerModeRandomPlay,
    /**
     *  单曲循环
     */
    TFAudioPlayerModeSinglePlay,
};

@interface TFAudioPlayerController : UIViewController
+ (TFAudioPlayerController *)sharePlayerViewController;

/*** 旋转View ***/
@property (nonatomic ,strong) TFTurnView *turnView;
@property (weak, nonatomic) IBOutlet UIImageView *underImageView;
/*** 提示信息 ***/
@property (nonatomic ,strong) TFProgressHUD *HUD;
/**
 *  播放器数据传入
 *
 *  @param array 传入所有数据model数组
 *  @param index 传入当前model在数组的下标
 */
- (void)initWithArray:(NSArray *)array index:(NSInteger)index type:(NSInteger)type;

/*** 开始播放 ***/
- (void)startPlay;
/*** 暂停播放 ***/
- (void)stopPlay;
/*** 播放/暂停按钮点击事件执行的方法 ***/
- (void)playerStatusOrStop;
/*** 上一曲 ***/
- (void)lastSong;
/*** 下一曲 ***/
- (void)nextSong;
@end

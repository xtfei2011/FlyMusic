
//
//  TFAudioPlayerController.m
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/17.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFAudioPlayerController.h"
#import "TFAudioPlayerController+TFExtension.h"
#import "NSString+TFTime.h"

@interface TFAudioPlayerController ()
@property (nonatomic ,strong) AVPlayerItem *playerItem;
@property (nonatomic ,strong) id playTimeObserver;                          /*** 播放进度观察者 ***/
@property (nonatomic ,strong) NSArray *songArray;                           /*** 歌曲数组 ***/
@property (nonatomic ,strong) NSArray *randomArray;                         /*** 随机数组 ***/
@property (nonatomic ,assign) NSInteger index;                              /*** 播放标记 ***/
@property (nonatomic ,assign) NSInteger type;
@property (nonatomic ,assign ,getter = playing) BOOL isPlay;                /*** 播放状态 ***/
@property (nonatomic ,assign ,getter = removeNotice) BOOL isRemoveNotice;   /*** 是否移除通知 ***/
@property (nonatomic ,assign) TFAudioPlayerMode playerMode;                 /*** 播放模式 ***/
@property (nonatomic ,strong) TFPlayMusic *playingModel;                    /*** 正在播放的模式 ***/
@property (nonatomic ,assign) CGFloat totalTime;                            /*** 总时长 ***/

/***********************************  播放界面UI  ***********************************/

@property (weak ,nonatomic) IBOutlet UISlider *paceSlider;                  /*** 进度条 ***/
@property (weak ,nonatomic) IBOutlet UIButton *playButton;                  /*** 播放按钮 ***/
@property (weak ,nonatomic) IBOutlet UILabel *titleLabel;                   /*** 歌名 ***/
@property (weak ,nonatomic) IBOutlet UILabel *singerLabel;                  /*** 歌手 ***/
@property (weak ,nonatomic) IBOutlet UILabel *playingTime;                  /*** 当前播放时间 ***/
@property (weak ,nonatomic) IBOutlet UILabel *maxTime;                      /*** 总时间 ***/
@property (weak ,nonatomic) IBOutlet UIButton *modeButton;                  /*** 播放模式按钮 ***/

@property (nonatomic ,strong) AVPlayer *player;
@end

static TFAudioPlayerController *audioVC;
@implementation TFAudioPlayerController

#pragma mark - 单例调用，保证后台播放
+ (TFAudioPlayerController *)sharePlayerViewController
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken ,^{
        
        audioVC = [[TFAudioPlayerController alloc] init];
        audioVC.view.backgroundColor = [UIColor whiteColor];
        audioVC.player = [[AVPlayer alloc]init];
        
        /*** 后台播放 ***/
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    });
    return audioVC;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.paceSlider setThumbImage:[UIImage imageNamed:@"slider_control"] forState:UIControlStateNormal];
    [self creatViews];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    [self setTurnViewFrame];
}

- (void)initWithArray:(NSArray *)array index:(NSInteger)index type:(NSInteger)type
{
    _index = index;
    _songArray = array;
    _randomArray = nil;
    _type = type;
    [self updateAudioPlayer];
}

- (void)updateAudioPlayer
{
    if (_isRemoveNotice) {
        // 如果已经存在 移除通知、KVO，各控件设初始值
        [self removeObserverAndNotification];
        [self initialControls];
        _isRemoveNotice = NO;
    }
    TFPlayMusic *model;
    // 判断是不是随机播放
    if (_playerMode == TFAudioPlayerModeRandomPlay) {
        // 如果是随机播放，判断随机数组是否有值
        if (_randomArray.count == 0) {
            // 如果随机数组没有值，播放当前音乐并给随机数组赋值
            model = [_songArray objectAtIndex:_index];
            _randomArray = [_songArray sortedArrayUsingComparator:(NSComparator)^(id obj1 ,id obj2) {
                return arc4random() % _songArray.count;
            }];
        }else{
            // 如果随机数组有值，从随机数组取值
            model = [_randomArray objectAtIndex:_index];
        }
    }else{
        model = [_songArray objectAtIndex:_index];
    }
    _playingModel = model;
    // 更新界面歌曲信息：歌名，歌手，图片
    [self updateUIDataWith:model];
    
    NSString *urlStr = @"";
    if (_type && model.objectInfo.rateFormats.url) {
        
        NSString *url = [model.objectInfo.rateFormats.url stringByReplacingOccurrencesOfString:@"ftp://218.200.160.122:21" withString:@"http://tyst.migu.cn"];
        urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    } else {
        NSString *url = [model.rateFormats.url stringByReplacingOccurrencesOfString:@"ftp://218.200.160.122:21" withString:@"http://tyst.migu.cn"];
        urlStr = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    
    _playerItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:urlStr]];
    
    [self.player replaceCurrentItemWithPlayerItem:_playerItem];
    [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];// 监听status属性
    [self monitoringPlayback:_playerItem];// 监听播放状态
    [self addEndTimeNotification];
    _isRemoveNotice = YES;
}

/*** 控件设初始值 ***/
- (void)initialControls
{
    [self stopPlay];
    self.playingTime.text = @"00:00";
    self.paceSlider.value = 0.0f;
    [self.turnView removeAnimation];
}

- (void)updateUIDataWith:(TFPlayMusic *)model
{
    self.titleLabel.text = _type ? model.objectInfo.songName : model.songName;
    self.singerLabel.text = _type ? model.objectInfo.singer : model.singer;
    
    [self setImageWith:model type:_type];
}

#pragma mark - KVO - status
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    AVPlayerItem *item = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        if ([_playerItem status] == AVPlayerStatusReadyToPlay) {
            TFLog(@"AVPlayerStatusReadyToPlay");
            /*** 获取视频总长度 ***/
            CMTime duration = item.duration;
            [self setMaxDuratuin:CMTimeGetSeconds(duration)];
            [self startPlay];
        }else if([_playerItem status] == AVPlayerStatusFailed) {
            TFLog(@"AVPlayerStatusFailed");
            [self stopPlay];
        }
    }
}

- (void)setMaxDuratuin:(float)duration
{
    _totalTime = duration;
    self.paceSlider.maximumValue = duration;
    self.maxTime.text = [NSString convertTime:duration];
}

#pragma mark - _playTimeObserver
- (void)monitoringPlayback:(AVPlayerItem *)item
{
    __weak typeof(self) weakSelf = self;
    //这里设置每秒执行30次
    _playTimeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1 ,30) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        // 计算当前在第几秒
        float currentPlayTime = (double)item.currentTime.value/item.currentTime.timescale;
        [weakSelf updateVideoSlider:currentPlayTime];
    }];
}

- (void)updateVideoSlider:(float)currentTime
{
    [self setLockViewWith:_playingModel currentTime:currentTime];
    self.paceSlider.value = currentTime;
    self.playingTime.text = [NSString convertTime:currentTime];
}

- (IBAction)changeSlider:(id)sender
{
    //转换成CMTime才能给player来控制播放进度
    CMTime dragedCMTime = CMTimeMake(self.paceSlider.value ,1);
    [_playerItem seekToTime:dragedCMTime];
}

- (void)addEndTimeNotification
{
    //给AVPlayerItem添加播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

- (void)playbackFinished:(NSNotification *)notification
{
    if (_playerMode == TFAudioPlayerModeSinglePlay) {
        _playerItem = [notification object];
        [_playerItem seekToTime:kCMTimeZero];
        [self.player play];
    }else{
        [self nextIndexAdd];
        [self updateAudioPlayer];
    }
}

#pragma mark --按钮点击事件--
- (IBAction)disMissSelfClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)playAndPauseClick:(id)sender {
    [self playerStatusOrStop];
}

- (void)playerStatusOrStop
{
    if (_isPlay) {
        [self stopPlay];
    }else{
        [self startPlay];
    }
}

- (IBAction)previousClick:(id)sender
{
    [self lastSong];
}

- (void)lastSong
{
    if (_playerMode != TFAudioPlayerModeSinglePlay) {
        [self previousIndexSub];
    }
    [self updateAudioPlayer];
}

- (IBAction)nextClick:(id)sender
{
    [self nextSong];
}

- (void)nextSong
{
    if (_playerMode != TFAudioPlayerModeSinglePlay) {
        [self nextIndexAdd];
    }
    [self updateAudioPlayer];
}

- (void)nextIndexAdd
{
    _index ++;
    if (_index == _songArray.count) {
        _index = 0;
    }
}

- (void)previousIndexSub
{
    _index --;
    if (_index < 0) {
        _index = _songArray.count -1;
    }
}

- (IBAction)clickPlayerMode:(id)sender
{
    switch (_playerMode) {
        case TFAudioPlayerModeOrderPlay:{
            _playerMode = TFAudioPlayerModeRandomPlay;
            [_modeButton setImage:[UIImage imageNamed:@"musicPlayer_random"] forState:UIControlStateNormal];
            [self progressHUDWith:@"随机播放"];
            _randomArray = [_songArray sortedArrayUsingComparator:(NSComparator)^(id obj1 ,id obj2) {
                return arc4random() % _songArray.count;
            }];
        }break;
        case TFAudioPlayerModeRandomPlay:
            _playerMode = TFAudioPlayerModeSinglePlay;
            [_modeButton setImage:[UIImage imageNamed:@"musicPlayer_cycle"] forState:UIControlStateNormal];
            [self progressHUDWith:@"单曲循环"];
            break;
        case TFAudioPlayerModeSinglePlay:
            _playerMode = TFAudioPlayerModeOrderPlay;
            [_modeButton setImage:[UIImage imageNamed:@"musicPlayer_order"] forState:UIControlStateNormal];
            [self progressHUDWith:@"顺序播放"];
            break;
        default:
            break;
    }
}

- (void)startPlay
{
    _isPlay = YES;
    [self.player play];
    [self.playButton setImage:[UIImage imageNamed:@"musicPlayer_play"] forState:UIControlStateNormal];
    // 开始旋转
    [self.turnView resumeLayer];
}

- (void)stopPlay
{
    _isPlay = NO;
    [self.player pause];
    [self.playButton setImage:[UIImage imageNamed:@"musicPlayer_stop"] forState:UIControlStateNormal];
    // 停止旋转
    [self.turnView pauseLayer];
}

- (IBAction)downloadAction:(id)sender
{
    TFLog(@"点击下载");
}
- (IBAction)rightButtonAction:(id)sender
{
    TFLog(@"分享");
}

#pragma mark - 移除通知&KVO
- (void)removeObserverAndNotification
{
    [self.player replaceCurrentItemWithPlayerItem:nil];
    [_playerItem removeObserver:self forKeyPath:@"status"];
    [self.player removeTimeObserver:_playTimeObserver];
    _playTimeObserver = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

#pragma mark - 后台UI设置
- (void)setLockViewWith:(TFPlayMusic *)model currentTime:(CGFloat)currentTime
{
    /*** 歌曲名 ***/
    NSString *song = _type ? model.objectInfo.songName : model.songName;
    /*** 歌手 ***/
    NSString *singer = _type ? model.objectInfo.singer : model.singer;
    
    NSMutableDictionary *musicInfo = [NSMutableDictionary dictionary];
    // 设置Singer
    [musicInfo setObject:song forKey:MPMediaItemPropertyArtist];
    // 设置歌曲名
    [musicInfo setObject:singer forKey:MPMediaItemPropertyTitle];
    // 设置封面
//    MPMediaItemArtwork *artwork;
//    NSString *urlStr = _type ? model.objectInfo.albumImgs.img : model.albumImgs.img;
//    artwork = [[MPMediaItemArtwork alloc] initWithImage:self.turnView.turnImage.image];
//    [musicInfo setObject:artwork forKey:MPMediaItemPropertyArtwork];
//    //音乐剩余时长
//    [musicInfo setObject:[NSNumber numberWithDouble:_totalTime] forKey:MPMediaItemPropertyPlaybackDuration];
//    //音乐当前播放时间
//    [musicInfo setObject:[NSNumber numberWithDouble:currentTime] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
//    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:musicInfo];
}
@end

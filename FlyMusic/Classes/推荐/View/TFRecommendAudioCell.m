//
//  TFRecommendAudioCell.m
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/16.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFRecommendAudioCell.h"

@interface TFRecommendAudioCell ()
/*** 图片 ***/
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
/*** 播放次数 ***/
@property (weak, nonatomic) IBOutlet UILabel *listenNumLabel;
/*** 标题 ***/
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *latestTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *viceTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *listenView;
@property (weak, nonatomic) IBOutlet UIImageView *baseView;

@end

@implementation TFRecommendAudioCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setRecommend:(TFRecommend *)recommend
{
    _recommend = recommend;
    
    _latestTitleLabel.hidden = YES;
    _viceTitleLabel.hidden = YES;
    _listenView.hidden = NO;
    _baseView.hidden = NO;
    _listenNumLabel.hidden = NO;
    
    TFInformation *information = recommend.objectInfo;
    TFPicture *picture = information.imgItem;
    TFQuantity *quantity = information.opNumItem;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:picture.img] placeholderImage:nil];
    _titleLabel.text = information.title;
    _listenNumLabel.text = quantity.playNum;
}

- (void)setLatestMusic:(TFNewMusic *)latestMusic
{
    _latestMusic = latestMusic;
    
    _listenView.hidden = YES;
    _baseView.hidden = YES;
    _listenNumLabel.hidden = YES;
    _latestTitleLabel.hidden = NO;
    _viceTitleLabel.hidden = NO;
    
    TFInformation *information = latestMusic.objectInfo;
    TFNewMusicPicture *picture = information.imgItems;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:picture.img] placeholderImage:nil];
    _latestTitleLabel.text = information.title;
    _viceTitleLabel.text = information.singer;
}
@end

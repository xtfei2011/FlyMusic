//
//  TFRecommendVideoCell.m
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/16.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFRecommendVideoCell.h"

@interface TFRecommendVideoCell ()
/*** 主题图片 ***/
@property (weak, nonatomic) IBOutlet UIImageView *themeView;
/*** 时间 ***/
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
/*** 介绍 ***/
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation TFRecommendVideoCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)setVideo:(TFVideo *)video
{
    _video = video;
    
    TFInformation *information = video.objectInfo;
    TFVideoPicture *picture = information.imgs;
    TFQuantity *quantity = information.opNumItem;
    
    [_themeView sd_setImageWithURL:[NSURL URLWithString:picture.img] placeholderImage:nil];
    
    _timeLabel.text = quantity.playNum;
    _titleLabel.text = information.songName;
}
@end

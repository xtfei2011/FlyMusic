//
//  TFClassifyCell.m
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/17.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFClassifyCell.h"

@interface TFClassifyCell ()
/*** 图片 ***/
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
/*** 时间 ***/
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
/*** 标题 ***/
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/*** 第一首歌 ***/
@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
/*** 第二首歌 ***/
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
/*** 第三首歌 ***/
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;
@end

@implementation TFClassifyCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)setClassify:(TFClassify *)classify
{
    _classify = classify;
    
    TFClassifyInfo *info = classify.objectInfo;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:info.columnSmallpicUrl] placeholderImage:nil];
    _timeLabel.text = [NSString stringWithFormat:@" %@更新",info.columnUpdateTime];
    _titleLabel.text = info.columnTitle;
    _firstLabel.text = info.contents[0][@"objectInfo"][@"songName"];
    _secondLabel.text = info.contents[1][@"objectInfo"][@"songName"];
    _thirdLabel.text = info.contents[2][@"objectInfo"][@"songName"];
}
@end

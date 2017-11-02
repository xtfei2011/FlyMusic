//
//  TFSingerHeadCell.m
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/22.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFSingerHeadCell.h"

@interface TFSingerHeadCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;
@end

@implementation TFSingerHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setHotSinger:(TFHotSinger *)hotSinger
{
    _hotSinger = hotSinger;
    
    TFSingerInfo *singerInfo = hotSinger.objectInfo;
    [_imgView setHeader:singerInfo.imgs.img];
    _singerLabel.text = singerInfo.singer;
}
@end

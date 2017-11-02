//
//  TFCommentDetailCell.m
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/18.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFCommentDetailCell.h"

@interface TFCommentDetailCell ()
/*** 歌手 - 歌名 ***/
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;
/*** 备注 ***/
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;
@end

@implementation TFCommentDetailCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setSongInfo:(TFCommentSongInfo *)songInfo
{
    _songInfo = songInfo;
    _singerLabel.text = songInfo.songName;
    _remarkLabel.text = [NSString stringWithFormat:@"%@ -- %@",songInfo.singer,songInfo.album];
}

- (void)setClassifyDetail:(TFClassifyDetail *)classifyDetail
{
    _classifyDetail = classifyDetail;
    
    TFCommentSongInfo *info = classifyDetail.objectInfo;
    
    _singerLabel.text = info.songName;
    _remarkLabel.text = [NSString stringWithFormat:@"%@ -- %@",info.singer,info.album];
}

/**
 *  重写setFrame:的作用: 监听设置cell的frame的过程
 */
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 0.5;
    [super setFrame:frame];
}
@end

//
//  TFSingerListCell.m
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/17.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFSingerListCell.h"

@interface TFSingerListCell ()
/*** 歌手 ***/
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;
@end

@implementation TFSingerListCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)setSinger:(TFSinger *)singer
{
    _singer = singer;
    
    TFSingerInfo *singerInfo = singer.objectInfo;
   
    _singerLabel.text = singerInfo.columnTitle;
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

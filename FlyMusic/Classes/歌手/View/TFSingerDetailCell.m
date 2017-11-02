//
//  TFSingerDetailCell.m
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/22.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFSingerDetailCell.h"

@interface TFSingerDetailCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;
@end

@implementation TFSingerDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSingerDetail:(TFSingerDetail *)singerDetail
{
    _singerDetail = singerDetail;
    
    [_imgView setHeader:singerDetail.objectInfo.imgs.img];
    _singerLabel.text = singerDetail.objectInfo.singer;
}

@end

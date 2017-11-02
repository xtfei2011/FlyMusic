//
//  TFSongListCell.m
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/17.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFSongListCell.h"

@interface TFSongListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;

@end

@implementation TFSongListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSong:(TFSong *)song
{
    _song = song;
    
    TFInformation *information = song.objectInfo;
    TFPicture *picture = information.imgItem;
    TFQuantity *quantity = information.opNumItem;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:picture.img] placeholderImage:nil];
    
    _playcountLabel.text = quantity.playNum;
    _titleLabel.text = information.title;
    _authorLabel.text = information.ownerName;
}
@end

//
//  TFCommentDetailTopView.m
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/18.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFCommentDetailTopView.h"
#import "TFQuantity.h"

@interface TFCommentDetailTopView ()
@property (nonatomic ,strong) UIView *baseView;
@property (nonatomic ,strong) UIImageView *headerView;
@property (nonatomic ,strong) UILabel *nameLabel;
@property (nonatomic ,strong) UILabel *playNumberLabel;
@end

@implementation TFCommentDetailTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = TFCommonBgColor;
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    _baseView = [[UIView alloc] initWithFrame:self.bounds];
    _baseView.backgroundColor = TFRGBColor(5, 5, 5, 0.3);
    _baseView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_baseView];
    
    _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(10, self.xtf_height - 70, 60, 60)];
    [_baseView addSubview:_headerView];
    
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headerView.frame) + 10, CGRectGetMinY(_headerView.frame) + 10, self.xtf_width/3, 20)];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.font = TFCommentTitleFont;
    [_baseView addSubview:_nameLabel];
    
    UIImageView *listenView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_headerView.frame) + 10, CGRectGetMaxY(_nameLabel.frame) + 10, 10, 10)];
    listenView.image = [UIImage imageNamed:@"list_detail_icn_music"];
    [_baseView addSubview:listenView];
    
    _playNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(listenView.frame) + 5, CGRectGetMaxY(_nameLabel.frame) + 5, self.xtf_width/3, 20)];
    _playNumberLabel.textColor = [UIColor whiteColor];
    _playNumberLabel.font = TFCommentTitleFont;
    [_baseView addSubview:_playNumberLabel];
}

- (void)setCommentDetail:(TFCommentDetail *)commentDetail
{
    _commentDetail = commentDetail;
    
    [self sd_setImageWithURL:[NSURL URLWithString:commentDetail.imgItem.img] placeholderImage:[UIImage imageNamed:@"001.jpg"]];
    
    [_headerView setHeader:commentDetail.ownerPic];
    _nameLabel.text = commentDetail.ownerName;
    _playNumberLabel.text = commentDetail.opNumItem.playNum;
}
@end

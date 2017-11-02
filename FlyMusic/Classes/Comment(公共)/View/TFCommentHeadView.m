//
//  TFCommentHeadView.m
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/17.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFCommentHeadView.h"

@interface TFCommentHeadView ()
/*** 图标 ***/
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/*** 文字 ***/
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/*** 更多 ***/
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@end

@implementation TFCommentHeadView

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

/*** 更多按钮 ***/
- (IBAction)moreButtonClick:(UIButton *)sender
{
    TFLog(@"--->更多");
}

- (void)setType:(NSInteger)type
{
    _type = type;
    
    _moreBtn.hidden = NO;
    
    if (type == 0) {
        
        self.xtf_y = ScrollViewHeight;
        self.xtf_height = 50;
        
        _iconView.image = [UIImage imageNamed:@"cm2_lists_icn_songlist"];
        _titleLabel.text = @"热门歌单";
        
    } else if (type == 1) {
        
        _iconView.image = [UIImage imageNamed:@"cm2_discover_icn_exclusive"];
        _titleLabel.text = @"最新音乐";
    } else if (type == 2) {
        
        _iconView.image = [UIImage imageNamed:@"cm2_discover_icn_mv"];
        _titleLabel.text = @"音乐视频";
    }
}
@end

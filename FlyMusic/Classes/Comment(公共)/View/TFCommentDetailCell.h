//
//  TFCommentDetailCell.h
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/18.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFCommentDetail.h"
#import "TFClassifyDetail.h"

@interface TFCommentDetailCell : UITableViewCell
/*** 序列号 ***/
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (nonatomic ,strong) TFCommentSongInfo *songInfo;
@property (nonatomic ,strong) TFClassifyDetail *classifyDetail;
@end

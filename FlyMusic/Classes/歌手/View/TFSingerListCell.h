//
//  TFSingerListCell.h
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/17.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFSinger.h"

@interface TFSingerListCell : UITableViewCell
/*** 名次 ***/
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (nonatomic ,strong) TFSinger *singer;
@end

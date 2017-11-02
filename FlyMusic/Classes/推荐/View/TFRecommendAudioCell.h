//
//  TFRecommendAudioCell.h
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/16.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TFRecommend.h"
#import "TFNewMusic.h"

@interface TFRecommendAudioCell : UICollectionViewCell
@property (nonatomic ,strong) TFRecommend *recommend;
@property (nonatomic ,strong) TFNewMusic *latestMusic;
@end

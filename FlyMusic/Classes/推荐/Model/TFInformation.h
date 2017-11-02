//
//  TFInformation.h
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/16.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFPicture.h"
#import "TFQuantity.h"

@class TFPicture,TFQuantity,TFVideoPicture,TFNewMusicPicture;
@interface TFInformation : NSObject
/*** 文字说明 ***/
@property (nonatomic ,strong) NSString *title;
/*** 播放数量 ***/
@property (nonatomic ,strong) TFQuantity *opNumItem;
/*** 主题图片 ***/
@property (nonatomic ,strong) TFPicture *imgItem;
@property (nonatomic ,strong) TFVideoPicture *imgs;
@property (nonatomic ,strong) TFNewMusicPicture *imgItems;
/*** 列表ID ***/
@property (nonatomic ,strong) NSString *musicListId;
@property (nonatomic ,strong) NSString *albumId;
/*** 发布人 ***/
@property (nonatomic ,strong) NSString *ownerName;
/*** 视频文字 ***/
@property (nonatomic ,strong) NSString *songName;
/*** 视频作者 ***/
@property (nonatomic ,strong) NSString *singer;
/*** 列表类型 ***/
@property (nonatomic ,strong) NSString *resourceType;
@end

//
//  TFCommentDetail.h
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/18.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFPicture.h"
//#import "TFQuantity.h"

@class TFCommentSongInfo,TFQuantity;
@interface TFCommentDetail : NSObject
/*** 作者 ***/
@property (nonatomic ,strong) NSString *ownerName;
/*** 头像 ***/
@property (nonatomic ,strong) NSString *ownerPic;
/*** 背景图 ***/
@property (nonatomic ,strong) TFPicture *imgItem;
/*** 榜单 ***/
@property (nonatomic ,strong) NSMutableArray<TFCommentSongInfo *> *songItems;
/*** 播放次数 ***/
@property (nonatomic ,strong) TFQuantity *opNumItem;
@end


@class TFCommentFormats,TFPicture;
@interface TFCommentSongInfo : NSObject
/*** 歌名 ***/
@property (nonatomic ,strong) NSString *songName;
/*** 歌手 ***/
@property (nonatomic ,strong) NSString *singer;
/*** 备注 ***/
@property (nonatomic ,strong) NSString *album;
/*** 音乐地址数组 ***/
@property (nonatomic ,strong) TFCommentFormats *rateFormats;
/*** 歌词地址 ***/
@property (nonatomic ,strong) NSString *lrcUrl;
/*** 头像 ***/
@property (nonatomic ,strong) TFPicture *albumImgs;
@end


@interface TFCommentFormats : NSObject
@property (nonatomic ,strong) NSString *url;
@end

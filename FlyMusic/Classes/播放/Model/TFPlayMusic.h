//
//  TFPlayMusic.h
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/18.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFCommentDetail.h"

@class TFCommentSongInfo;
@interface TFPlayMusic : NSObject

@property (nonatomic ,strong) TFCommentSongInfo *objectInfo;
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

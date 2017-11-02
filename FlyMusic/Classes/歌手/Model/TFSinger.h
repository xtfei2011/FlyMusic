//
//  TFSinger.h
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/19.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFInformation.h"

@class TFSingerInfo;
@interface TFSinger : NSObject
@property (nonatomic ,strong) TFSingerInfo *objectInfo;
@end

@class TFPicture;
@interface TFSingerInfo : NSObject
@property (nonatomic ,strong) NSString *columnTitle;
@property (nonatomic ,strong) NSString *singer;
@property (nonatomic ,strong) NSString *columnId;
@property (nonatomic ,strong) TFPicture *imgs;
@end

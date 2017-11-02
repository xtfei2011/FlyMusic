//
//  TFClassify.h
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/17.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFClassifyInfo.h"

@class TFClassifyInfo;
@interface TFClassify : NSObject
/*** 专题ID ***/
@property (nonatomic ,strong) NSString *contentId;

@property (nonatomic ,strong) TFClassifyInfo *objectInfo;
@end

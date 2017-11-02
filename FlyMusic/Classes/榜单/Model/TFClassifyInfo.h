//
//  TFClassifyInfo.h
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/19.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFClassifyInfo : NSObject
/*** 图片 ***/
@property (nonatomic ,strong) NSString *columnSmallpicUrl;
@property (nonatomic ,strong) NSString *columnPicUrl;
/*** 标题 ***/
@property (nonatomic ,strong) NSString *columnTitle;
/*** 信息 ***/
@property (nonatomic ,strong) NSArray *contents;
/*** 更新时间 ***/
@property (nonatomic ,strong) NSString *columnUpdateTime;
@end

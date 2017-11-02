//
//  TFSinger.m
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/19.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFSinger.h"

@implementation TFSinger

@end

@implementation TFSingerInfo
+ (void)load
{
    [TFSingerInfo mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        
        return @{
                 @"imgs" : @"imgs[0]",
                 };
    }];
}
@end

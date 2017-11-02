//
//  TFInformation.m
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/16.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFInformation.h"

@implementation TFInformation

+ (void)load
{
    [TFInformation mj_setupReplacedKeyFromPropertyName:^NSDictionary *{

        return @{
                 @"imgs" : @"imgs[2]",
                 @"imgItems" : @"imgItems[1]",
                 };
    }];
}

@end

//
//  TFQuantity.m
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/19.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFQuantity.h"

@implementation TFQuantity
- (NSString *)playNum
{
    if ([_playNum integerValue] >= 10000) {
        
        _playNum = [NSString stringWithFormat:@"%.2f万", [_playNum integerValue] / 10000.0];
    } else {
        _playNum = [NSString stringWithFormat:@"%ld", [_playNum integerValue]];
    }
    return _playNum;
}
@end

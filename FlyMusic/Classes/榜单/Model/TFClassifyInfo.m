//
//  TFClassifyInfo.m
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/19.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFClassifyInfo.h"

@implementation TFClassifyInfo
static NSDateFormatter *fmt_;
static NSCalendar *calendar_;

+ (void)initialize
{
    fmt_ = [[NSDateFormatter alloc] init];
    calendar_ = [NSCalendar calendar];
}

- (NSString *)columnUpdateTime
{
    // 获取日期
    fmt_.dateFormat = @"yyyy-MM-dd";
    NSDate *createdAtDate = [fmt_ dateFromString:_columnUpdateTime];
    
    if (createdAtDate.isThisYear) {
        
            fmt_.dateFormat = @"MM月dd日";
            return [fmt_ stringFromDate:createdAtDate];
        
    } else {
        
        return _columnUpdateTime;
    }
}
@end

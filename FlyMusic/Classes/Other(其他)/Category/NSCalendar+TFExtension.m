//
//  NSCalendar+TFExtension.m
//  多酷音乐
//
//  Created by 谢腾飞 on 2016/12/20.
//  Copyright © 2016年 谢腾飞. All rights reserved.
//

#import "NSCalendar+TFExtension.h"

@implementation NSCalendar (TFExtension)

+ (instancetype)calendar
{
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    } else {
        return [NSCalendar currentCalendar];
    }
}
@end

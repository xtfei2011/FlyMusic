//
//  NSDate+TFExtension.h
//  多酷音乐
//
//  Created by 谢腾飞 on 2016/12/20.
//  Copyright © 2016年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (TFExtension)

/*** 是否为今年 ***/
- (BOOL)isThisYear;

/*** 是否为今天 ***/
- (BOOL)isToday;

/*** 是否为昨天 ***/
- (BOOL)isYesterday;

/*** 是否为明天 ***/
- (BOOL)isTomorrow;
@end

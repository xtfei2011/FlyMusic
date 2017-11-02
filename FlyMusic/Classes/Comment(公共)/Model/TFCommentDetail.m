//
//  TFCommentDetail.m
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/18.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFCommentDetail.h"

@implementation TFCommentDetail

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"songItems": [TFCommentSongInfo class]};
}
@end


@implementation TFCommentSongInfo

+ (void)load
{
    [TFCommentSongInfo mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"rateFormats" : @"rateFormats[0]",
                 @"albumImgs" : @"albumImgs[2]"
                 };    }];
}
@end

@implementation TFCommentFormats

@end

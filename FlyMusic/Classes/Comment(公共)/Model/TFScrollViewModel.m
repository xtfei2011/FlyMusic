//
//  TFScrollViewModel.m
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/14.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFScrollViewModel.h"

@implementation TFScrollViewModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        NSDictionary *info = [dict objectForKey:@"objectInfo"];
        NSArray *imgArr = [info objectForKey:@"imgList"];
        NSDictionary *dic = [imgArr objectAtIndex:0];
        self.imageUrl = dic[@"img"];
    }
    return self;
}

+ (instancetype)scrollViewWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}
@end

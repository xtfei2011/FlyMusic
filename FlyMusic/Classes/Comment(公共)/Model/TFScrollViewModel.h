//
//  TFScrollViewModel.h
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/14.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFScrollViewModel : NSObject
@property (nonatomic ,strong) NSString *imageUrl;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)scrollViewWithDict:(NSDictionary *)dict;
@end

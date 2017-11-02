//
//  UIImage+TFExtension.h
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/17.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TFExtension)
/**
 *  返回圆形图片
 */
- (instancetype)circleImage;

+ (instancetype)circleImage:(NSString *)name;
@end

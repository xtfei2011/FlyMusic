//
//  UIBarButtonItem+TFExtension.m
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/14.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "UIBarButtonItem+TFExtension.h"

@implementation UIBarButtonItem (TFExtension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [itemButton setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [itemButton setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    itemButton.xtf_size = itemButton.currentBackgroundImage.size;
    [itemButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:itemButton];
}
@end

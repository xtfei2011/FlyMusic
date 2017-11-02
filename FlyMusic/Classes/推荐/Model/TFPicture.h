//
//  TFPicture.h
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/19.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFPicture : NSObject
/*** 主题图片 ***/
@property (nonatomic ,strong) NSString *img;
@end

@interface TFVideoPicture : TFPicture

@end

@interface TFNewMusicPicture : TFPicture

@end

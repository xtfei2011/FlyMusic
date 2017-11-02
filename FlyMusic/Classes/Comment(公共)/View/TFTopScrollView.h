//
//  TFTopScrollView.h
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/14.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClickPushDelegate <NSObject>
- (void)pushController:(NSInteger)selectIndex;
@end

@interface TFTopScrollView : UIView
/*** 数据源 ***/
@property (nonatomic ,strong) NSArray *dataSource;
@property (nonatomic ,assign) id<ClickPushDelegate>delegate;

/*** 开始滚动 ***/
- (void)startScroll;
/*** 停止滚动 ***/
- (void)stopScroll;

@end

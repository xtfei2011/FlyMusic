//
//  TFTurnView.h
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/18.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TFTurnView : UIView
@property (nonatomic, strong) UIImageView *turnImage;

- (void)setTurnViewLayoutWithFrame:(CGRect)frame;
/** 添加动画 */
- (void)addAnimation;
/** 停止 */
-(void)pauseLayer;
/** 恢复 */
-(void)resumeLayer;
/** 移除动画 */
- (void)removeAnimation;
@end

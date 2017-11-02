//
//  TFTurnView.m
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/18.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

#import "TFTurnView.h"

@implementation TFTurnView
CGFloat const BorderWidth = 6.0f;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        self.turnImage = [[UIImageView alloc] init];
        [self addSubview:self.turnImage];
    }
    return self;
}

- (void)setTurnViewLayoutWithFrame:(CGRect)frame
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = CGRectGetWidth(frame)/2.f;
    self.turnImage.frame = CGRectMake(BorderWidth, BorderWidth, frame.size.width - BorderWidth * 2, frame.size.width - BorderWidth * 2);
    self.turnImage.layer.masksToBounds = YES;
    self.turnImage.layer.cornerRadius = CGRectGetWidth(self.turnImage.frame)/2.f;
}

/*** 添加动画 ***/
- (void)addAnimation
{
    CABasicAnimation *monkeyAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    monkeyAnimation.toValue = [NSNumber numberWithFloat:2.0 * M_PI];
    monkeyAnimation.duration = 20.0f;
    monkeyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    monkeyAnimation.cumulative = NO;
    monkeyAnimation.removedOnCompletion = NO;
    monkeyAnimation.fillMode = kCAFillModeForwards;
    monkeyAnimation.repeatCount = FLT_MAX;
    [self.turnImage.layer addAnimation:monkeyAnimation forKey:@"AnimatedKey"];
    [self.turnImage stopAnimating];
    self.turnImage.layer.speed = 0.0;
}

/*** 停止 ***/
- (void)pauseLayer
{
    CFTimeInterval pausedTime = [self.turnImage.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.turnImage.layer.speed = 0.0;
    self.turnImage.layer.timeOffset = pausedTime;
}

/*** 恢复 ***/
- (void)resumeLayer
{
    CFTimeInterval pausedTime = self.turnImage.layer.timeOffset;
    self.turnImage.layer.speed = 1.0;
    self.turnImage.layer.timeOffset = 0.0;
    self.turnImage.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self.turnImage.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.turnImage.layer.beginTime = timeSincePause;
}

- (void)removeAnimation
{
    [self.turnImage.layer removeAllAnimations];
}
@end

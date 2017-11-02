//
//  UIImage+TFEffects.h
//  FlyMusic
//
//  Created by 谢腾飞 on 2017/8/21.
//  Copyright © 2017年 谢腾飞. All rights reserved.
//

@import UIKit;

@interface UIImage (TFEffects)

- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;
@end

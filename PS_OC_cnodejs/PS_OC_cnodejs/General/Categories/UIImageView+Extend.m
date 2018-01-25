//
//  UIImageView+Extend.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/5.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "UIImageView+Extend.h"

@implementation UIImageView (Extend)

// 切圆角 参考链接：http://www.cocoachina.com/ios/20171204/21407.html

- (UIImageView *)roundedRectImageViewWithCornerRadius:(CGFloat)cornerRadius {
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = bezierPath.CGPath;
    self.layer.mask = layer;
    return self;
}

@end

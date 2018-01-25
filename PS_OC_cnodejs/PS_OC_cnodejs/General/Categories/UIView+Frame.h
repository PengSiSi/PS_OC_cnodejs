//
//  UIView+Frame.h
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/14.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property CGFloat width;
@property CGFloat height;
@property CGFloat x;
@property CGFloat y;
@property CGFloat centerX;
@property CGFloat centerY;
@property CGSize size;
@property CGFloat left;
@property CGFloat right;
@property CGFloat top;
@property CGFloat bottom;

+ (instancetype)viewFromXIB;
- (BOOL)isShowingOnKeyWindow;

#pragma mark - 设置圆角

/**
 设置上边圆角
 */
- (void)setCornerOnTop:(CGFloat) conner;

/**
 设置下边圆角
 */
- (void)setCornerOnBottom:(CGFloat) conner;
/**
 设置左边圆角
 */
- (void)setCornerOnLeft:(CGFloat) conner;
/**
 设置右边圆角
 */
- (void)setCornerOnRight:(CGFloat) conner;

/**
 设置左上圆角
 */
- (void)setCornerOnTopLeft:(CGFloat) conner;

/**
 设置右上圆角
 */
- (void)setCornerOnTopRight:(CGFloat) conner;
/**
 设置左下圆角
 */
- (void)setCornerOnBottomLeft:(CGFloat) conner;
/**
 设置右下圆角
 */
- (void)setCornerOnBottomRight:(CGFloat) conner;


/**
 设置所有圆角
 */
- (void)setAllCorner:(CGFloat) conner;


@end

//
//  LoadingView.h
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/19.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) UIEdgeInsets edgeInset;

// 便利方法
+ (LoadingView *)loadingForView:(UIView *)view;

+ (void)showLoadingInView:(UIView *)view;

+ (void)showLoadingInView:(UIView *)view edgeInset:(UIEdgeInsets)edgeInset;

+ (void)showLoadingInView:(UIView *)view topEdge:(CGFloat)topEdge;

- (void)showInView:(UIView *)view;

+ (void)hideLoadingForView:(UIView *)view;

+ (void)hideAllLoadingForView:(UIView *)view;

- (void)hide;

@end


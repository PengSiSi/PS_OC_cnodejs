//
//  LoadingView.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/19.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "LoadingView.h"
#import "UIViewExt.h"

static NSArray *_refreshingImages = nil;

@implementation LoadingView

+ (instancetype)loadViewWithFrame:(CGRect)frame{
    LoadingView *loadView = [[self alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    return loadView;
}

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addAnimalImages];
    }
    return self;
}

- (void)addAnimalImages{
     self.imageView.animationDuration = 1.5;
     self.imageView.animationImages = [self refreshingImages];
}

+ (LoadingView *)loadingForView:(UIView *)view {
    NSEnumerator *reverseSubviews = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in reverseSubviews) {
        if ([subview isKindOfClass:self]) {
            return (LoadingView *)subview;
        }
    }
    return nil;
}

+ (void)showLoadingInView:(UIView *)view {
    [self showLoadingInView:view edgeInset:UIEdgeInsetsZero];
}

+ (void)showLoadingInView:(UIView *)view edgeInset:(UIEdgeInsets)edgeInset {
    LoadingView *loadingView = [self loadViewWithFrame:view.frame];
    loadingView.edgeInset = edgeInset;
    [loadingView showInView:view];
}

+ (void)showLoadingInView:(UIView *)view topEdge:(CGFloat)topEdge {
    LoadingView *loadingView = [self loadViewWithFrame:view.frame];
    loadingView.edgeInset = UIEdgeInsetsMake(topEdge, 0, 0, 0);
    [loadingView showInView:view];
}

- (void)showInView:(UIView *)view {
    if (!view) {
        return ;
    }
    if (self.superview != view) {
        [self removeFromSuperview];
        [view addSubview:self];
        [view bringSubviewToFront:self];
    }
    [self.imageView startAnimating];
}

+ (void)hideLoadingForView:(UIView *)view {
    LoadingView *loadingView = [self loadingForView:view];
    if (loadingView) {
        [loadingView hide];
    }
}

+ (void)hideAllLoadingForView:(UIView *)view {
    NSEnumerator *reverseSubviews = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in reverseSubviews) {
        if ([subview isKindOfClass:self]) {
            [(LoadingView *)subview hideNoAnimation];
        }
    }
}

- (void)hide {
    self.alpha = 1.0;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self hideNoAnimation];
    }];
}

- (void)hideNoAnimation{
    [self.imageView stopAnimating];
    [self removeFromSuperview];
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [UIImageView new];
        UIImage *image = [UIImage imageNamed:@"loadingcai2new001"];
        _imageView.size = CGSizeMake(image.size.width, image.size.height);
        _imageView.left = (self.width - _imageView.size.width) / 2.0;
        _imageView.top = (self.height - _imageView.size.height) / 2.0 - _imageView.size.height/4;
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (NSArray *)refreshingImages{
     if (!_refreshingImages) {
         NSMutableArray *refreshingImages  = [NSMutableArray array];
         for (int i = 1; i < 25; ++i) {
             UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loadingcai2new00%d",i]];
             [refreshingImages addObject:image];
         }
         _refreshingImages = [refreshingImages copy];
     }
     return _refreshingImages;
}
@end

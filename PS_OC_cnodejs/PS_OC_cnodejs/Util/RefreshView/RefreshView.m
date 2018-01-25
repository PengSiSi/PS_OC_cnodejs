//
//  RefreshView.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2018/1/24.
//  Copyright © 2018年 思 彭. All rights reserved.
//

#import "RefreshView.h"

#define kWidth [UIScreen mainScreen].bounds.size.width

@interface RefreshView()

/** 图形变化 */
@property (nonatomic, strong) UIImageView *imgView;
/** 设置加载位置 */
@property (nonatomic, assign) CGRect loadFrame;

@end

@implementation RefreshView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.loadFrame = frame;
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.imgView.contentMode = UIViewContentModeScaleAspectFit;
        self.imgView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [self addSubview:self.imgView];
    }
    return self;
}

- (void)setRefreshStyle:(RefreshViewStyle)refreshStyle {
    if (_refreshStyle != refreshStyle) {
        _refreshStyle = refreshStyle;
    }
    // 根据控件状态 设置图片
    switch (refreshStyle) {
        case RefreshViewStyleNormal:
        {
            self.imgView.image = [UIImage imageNamed:@"ill_cos_liked"];
            [UIView animateWithDuration:0.2 animations:^{
                self.imgView.transform = CGAffineTransformIdentity;
            }];
        }
            break;
        case RefreshViewStylePulling:
        {
            self.imgView.image = [UIImage imageNamed:@"ill_cos_liked"];
            [UIView animateWithDuration:0.2 animations:^{
                self.imgView.transform = CGAffineTransformMakeRotation(M_PI);
            }];
        }
            break;
        case RefreshViewStyleLoad:
        {
            self.imgView.image = [UIImage imageNamed:@"double_line_one"];
        }
            break;
    }
}

/** 开始 */
-(void)startAnimation:(void(^)(void))start{
    
    
    if (![self.imgView.layer.animationKeys containsObject:@"rotationAnimation"]) {
        
        CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.fromValue = [NSNumber numberWithInt:0];
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
        rotationAnimation.duration = 0.7;
        rotationAnimation.repeatCount = HUGE_VALF;
        
        rotationAnimation.cumulative = YES;
        // 切换界面 animationKeys 清空了 需要设置removedOnCompletion = NO;
        rotationAnimation.removedOnCompletion = NO;
        rotationAnimation.fillMode = kCAFillModeForwards;
        
        [self.imgView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        
        start();
    }
}

/** 移除 */
-(void)removeAnimation{
    if ([self.imgView.layer.animationKeys containsObject:@"rotationAnimation"]) {
        
        [UIView animateWithDuration:0.7 animations:^{
            
            self.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            self.frame = CGRectMake((kWidth - self.loadFrame.size.width) / 2, -self.loadFrame.size.height, self.loadFrame.size.width, self.loadFrame.size.height);
            
            self.alpha = 1;
            
            // 手动释放
            [self.imgView.layer removeAnimationForKey:@"rotationAnimation"];
            
            self.refreshStyle = RefreshViewStyleNormal;
            
        }];
    }
    
}

//3 刷新控件设置
-(void)contentOffsetY:(CGFloat)scrollY withDragging:(BOOL)isDragging isStyleLoad:(void(^)(void))load{
    
    // 3.0 如何不是下拉操作 直接返回
    if (scrollY < 0) {
        return;
    }
    
    // 3.1 除正在刷新, 其余情况 高度跟随变化
    if (self.refreshStyle != RefreshViewStyleLoad) {
        
        self.frame = CGRectMake(self.loadFrame.origin.x, scrollY - self.loadFrame.size.height, self.loadFrame.size.width, self.loadFrame.size.height);
        
    }
    
    
    if (isDragging) { // 3.2 正在拉拽
        
        if (scrollY >= self.refreshOffset  && self.refreshStyle == RefreshViewStyleNormal) {
            
            // 拉拽超过临界点, 修改状态为[临界拉拽]
            self.refreshStyle = RefreshViewStylePulling;
            
        }else if (scrollY < self.refreshOffset  && self.refreshStyle == RefreshViewStylePulling){
            
            // 拉拽小于临界点, 修改状态为[正常]
            self.refreshStyle = RefreshViewStyleNormal;
        }
        
        
    } else { // 3.3 未处于拉拽状态, 并且状态为[临界拉拽]
        
        if (self.refreshStyle == RefreshViewStylePulling) {
            
            self.refreshStyle = RefreshViewStyleLoad;
            
            [UIView animateWithDuration:0.2 animations:^{
                self.frame = self.loadFrame;
            }];
            // 刷新界面
            [self startAnimation:^{
                
                load();
            }];
        }
    }
}

@end

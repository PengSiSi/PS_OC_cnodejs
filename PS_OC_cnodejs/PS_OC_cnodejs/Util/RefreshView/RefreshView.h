//
//  RefreshView.h
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2018/1/24.
//  Copyright © 2018年 思 彭. All rights reserved.

// 参考链接： http://www.cocoachina.com/ios/20180123/21940.html

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RefreshViewStyle) {
    RefreshViewStyleNormal,  // 普通状态
    RefreshViewStylePulling, // 超过临界点
    RefreshViewStyleLoad     // 正在刷新
};

@interface RefreshView : UIView

/** 刷新控件状态 */
@property (nonatomic, assign) RefreshViewStyle refreshStyle;
/** 状态变化临界值 */
@property (nonatomic, assign) CGFloat refreshOffset;
/** 开始 */
-(void)startAnimation:(void(^)(void))start;
/** 移除 */
-(void)removeAnimation;
/**
 刷新控件设置
 @param scrollY 下拉值
 @param isDragging 是否正在拖拽
 @param load 加载刷新
 */
-(void)contentOffsetY:(CGFloat)scrollY withDragging:(BOOL)isDragging isStyleLoad:(void(^)(void))load;

@end

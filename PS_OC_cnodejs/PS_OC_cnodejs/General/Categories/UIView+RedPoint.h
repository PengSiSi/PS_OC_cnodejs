//
//  UIView+RedPoint.h
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/15.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RedPoint)

- (void)showRedAtOffSetX:(float)offsetX AndOffSetY:(float)offsetY OrValue:(NSString *)value;
- (void)hideRedPoint;

//tabbar方法
- (void)showBadgeOnItemIndex:(int)index; //显示小红点
- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点

@end

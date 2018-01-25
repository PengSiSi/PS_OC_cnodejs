//
//  UIView+Extension.h
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/29.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)


/**
 * 获取view所在的controller
 */
@property (nonatomic, weak, readonly) UIViewController *viewController;

/**
 * 获取view所在的navigationController
 */
@property (nonatomic, weak, readonly) UINavigationController *navigationController;

/**
 * 当前view是不是正在屏幕上展示了
 */
@property (nonatomic, assign, readonly) BOOL isShowInScreen;

/**
 * 移除所有子视图
 */
- (void)removeAllSubviews;

/**
 *  找到指定类名的SubView对象
 */
- (id)findSubViewWithClass:(Class)subViewClass;

/**
 *  找到指定类名的SuperView对象
 */
- (id)findSuperViewWithClass:(Class)superViewClass;

/**
 *  找到第一响应者
 */
- (UIView *)findFirstResponder;

@property (nonatomic, strong) NSString *stringTag;

@end

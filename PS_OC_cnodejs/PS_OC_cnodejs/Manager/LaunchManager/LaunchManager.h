//
//  LaunchManager.h
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/29.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RootTabbarViewController.h"

@interface LaunchManager : NSObject

/// 当前根控制器
@property (nonatomic, strong, readonly) __kindof UIViewController *currentRootVC;

/// 根tabBarController
@property (nonatomic, strong, readonly) RootTabbarViewController *tabBarController;

+ (LaunchManager *)sharedInstance;

/**
 *  启动，初始化
 */
- (void)launchInWindow:(UIWindow *)window;

// NS_UNAVAILABLE表示外部不能在 IDE 自动补全时，就不会索引到该方法，并且如果强制调用该方法，编译器会报错（但并不代表着方法不能被调用，runtime 依然可以做到）。
// 参考博客： https://www.jianshu.com/p/5654942cd8f7
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

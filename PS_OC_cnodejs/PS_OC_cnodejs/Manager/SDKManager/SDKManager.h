//
//  SDKManager.h
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/29.
//  Copyright © 2017年 思 彭. All rights reserved.

// 第三方配置管理类

#import <Foundation/Foundation.h>

@interface SDKManager : NSObject

+ (SDKManager *)sharedInstance;

/**
 *  启动，初始化
 */
- (void)launchInWindow:(UIWindow *)window;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

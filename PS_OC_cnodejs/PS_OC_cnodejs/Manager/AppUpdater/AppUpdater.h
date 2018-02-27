//
//  AppUpdater.h
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2018/2/5.
//  Copyright © 2018年 思 彭. All rights reserved.

// 检查更新

#import <Foundation/Foundation.h>

@interface AppUpdater : NSObject

// 单例
+ (AppUpdater *)shareInstance;

@end

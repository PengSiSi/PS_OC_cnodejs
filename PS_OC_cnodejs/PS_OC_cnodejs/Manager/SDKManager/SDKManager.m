//
//  SDKManager.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/29.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "SDKManager.h"
#import <AFNetworking.h>
#import <CocoaLumberjack.h>

@implementation SDKManager

+ (SDKManager *)sharedInstance {
    static SDKManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
    });
    return manager;
}

- (void)launchInWindow:(UIWindow *)window {
    
    // 友盟统计
    
    // 网络环境监测
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 日志
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24;
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];
}
@end

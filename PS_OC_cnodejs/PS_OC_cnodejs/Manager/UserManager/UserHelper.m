//
//  UserHelper.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/29.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "UserHelper.h"

@interface UserHelper()

@end

@implementation UserHelper

+ (UserHelper *)sharedHelper {
    static UserHelper *helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[self alloc]init];
    });
    return helper;
}

- (void)loginTestAccount {
    // 初始化用户信息
    
    // 保存登录信息或者userID或者状态到本地
}

- (void)saveUserInfo {
    // 保存用户信息
}

- (MineInfoModel *)userInfoModel {
    // 取得存的userInfoModel返回外部使用
    return nil;
}

- (NSString *)userID {
    // 取得本地userID返回
    return @"";
}

- (BOOL)hasLogin {
    // 返回是否登录
    // 直接判断userID长度也可以
    return YES;
}

@end

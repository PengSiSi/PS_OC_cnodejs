//
//  UserHelper.h
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/29.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MineInfoModel.h"

@interface UserHelper : NSObject

@property (nonatomic, strong) MineInfoModel *userInfoModel;
@property (nonatomic, strong, readonly) NSString *userID;
@property (nonatomic, assign, readonly) BOOL hasLogin;


+ (UserHelper *)sharedHelper;
- (void)loginTestAccount;

@end

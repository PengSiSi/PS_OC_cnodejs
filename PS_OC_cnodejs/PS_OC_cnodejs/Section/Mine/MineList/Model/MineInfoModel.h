//
//  MineInfoModel.h
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/14.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthorModel.h"

@interface TopicModel : NSObject

@property (nonatomic, strong) AuthorModel *author;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *last_reply_at;
@property (nonatomic, copy) NSString *id;

@end

@interface MineInfoModel : NSObject

@property (nonatomic, copy) NSString *loginname;
@property (nonatomic, copy) NSString *avatar_url;
@property (nonatomic, copy) NSString *githubUsername;
@property (nonatomic, copy) NSString *create_at;
@property (nonatomic, copy) NSString *score;
@property (nonatomic, strong) NSArray <TopicModel *>*recent_topics;
@property (nonatomic, strong) NSArray <TopicModel *>*recent_replies;

@end

//
//  TopicDetailModel.h
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/6.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthorModel.h"

@interface ReplyModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, strong) AuthorModel *author;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSArray *ups;
@property (nonatomic, copy) NSString *create_at;
@property (nonatomic, copy) NSString *reply_id;
@property (nonatomic, assign) BOOL is_uped;

@end

@interface TopicDetailModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *author_id;
@property (nonatomic, copy) NSString *tab;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *last_reply_at;
@property (nonatomic, copy) NSString *good;
@property (nonatomic, copy) NSString *top;
@property (nonatomic, assign) NSInteger reply_count;
@property (nonatomic, assign) NSInteger visit_count;
@property (nonatomic, copy) NSString *create_at;
@property (nonatomic, strong) AuthorModel *author;
@property (nonatomic, strong) NSArray<ReplyModel *> *replies;

@end

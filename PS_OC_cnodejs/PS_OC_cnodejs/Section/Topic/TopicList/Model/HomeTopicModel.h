//
//  HomeTopicModel.h
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/5.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthorModel.h"

@interface HomeTopicModel : NSObject

@property (nonatomic, copy) NSString *topicID;
@property (nonatomic, copy) NSString *author_id;
@property (nonatomic, copy) NSString *tab;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *last_reply_at;
@property (nonatomic, assign) BOOL good;
@property (nonatomic, assign) BOOL top;
@property (nonatomic, assign) NSInteger reply_count;
@property (nonatomic, assign) NSInteger visit_count;
@property (nonatomic, copy) NSString *create_at;
@property (nonatomic, strong) AuthorModel *author;

@end

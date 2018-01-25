//
//  TopicDetailModel.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/6.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "TopicDetailModel.h"

@implementation ReplyModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID": @"id"};
}
@end

@implementation TopicDetailModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID": @"id"};
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"replies":  [ReplyModel class]};
}
@end

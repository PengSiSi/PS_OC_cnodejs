//
//  HotRecommendListModel.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/20.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "HotRecommendListModel.h"

@implementation HotRecommendListModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"data" : [HotRecommendModel class]
             };
}
@end

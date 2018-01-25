//
//  HotRecommendListModel.h
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/20.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HotRecommendModel.h"

@interface HotRecommendListModel : NSObject

/** 是否还可以加载更多 */
@property (nonatomic, assign) BOOL          hasMore;
/** endPicId */
@property (nonatomic, copy) NSString        *endPicId;
/** endCosId */
@property (nonatomic, copy) NSString        *endCosId;
/** 热推model */
@property (nonatomic, strong) NSMutableArray<HotRecommendModel *> *data;

@end

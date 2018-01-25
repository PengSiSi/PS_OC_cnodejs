//
//  HotRecommendModel.h
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/20.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotRecommendModel : NSObject


/** 图片url */
@property (nonatomic, copy) NSString    *imgId;
/** 封面图后缀 */
@property (nonatomic, copy) NSString    *imageSuffix;
/** 宽度 */
@property (nonatomic, assign) CGFloat   width;
/* 实际宽度 * 2px */
@property (nonatomic, assign) CGFloat   realWidth;
/** 高度 */
@property (nonatomic, assign) CGFloat   height;
/* 实际高度 * 2px */
@property (nonatomic, assign) CGFloat   realHeight;
/** size */
@property (nonatomic, assign) CGFloat   size;
/** postId */
@property (nonatomic, copy) NSString    *postId;
/** 标题 */
@property (nonatomic, copy) NSString    *title;
/** 摘要 */
@property (nonatomic, copy) NSString    *summary;
/** 状态 */
@property (nonatomic, assign) UInt64    state;
/** 数量 */
@property (nonatomic, assign) CGFloat   imgCount;
/** 类型 */
@property (nonatomic, assign) UInt64    type;
/** 是否点赞 */
@property (nonatomic, assign) BOOL      hasPraise;
/** 排名 */
@property (nonatomic, assign) UInt64    top;
/** 作者信息 */
//@property (nonatomic, strong) ZMAuthorModel *author;
/** 作品数量 */
@property (nonatomic, assign) UInt64    wordNum;

@end

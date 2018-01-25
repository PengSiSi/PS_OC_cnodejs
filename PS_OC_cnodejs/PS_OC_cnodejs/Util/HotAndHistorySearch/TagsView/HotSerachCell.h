//
//  HotSerachCell.h
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/6.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagsView.h"

@interface HotSerachCell : UITableViewCell

/** 热门搜索tagView */
@property (nonatomic, strong) TagsView *tagsView;

/** 热门搜索标签的数据源数组 */
@property (nonatomic, strong) NSArray *hotSearchArr;

@end

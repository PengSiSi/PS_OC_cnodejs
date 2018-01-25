//
//  MyTableViewCell.h
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/20.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaterFlowLayout.h"
#import "ProfileView.h"
#import "ContentView.h"
#import "HotRecommendModel.h"

typedef NS_ENUM(NSInteger,itemStyle){
    itemStyleDouble = 0,    //两列
    itemStyleSingle         //单列
};

@interface MyTableViewCell : UITableViewCell

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) CGFloat cacheHeight;
@property (nonatomic, assign) BOOL    needUpdate;
@property (nonatomic, copy) void(^updateCellHeight)(CGFloat);

@property (nonatomic, assign) itemStyle style;

@end

@interface MyCollectionViewCell : UICollectionViewCell

/** 容器 */
@property (nonatomic, strong) UIView                                        *mainView;
@property (nonatomic, strong) ContentView *view;
@property (nonatomic, strong) ProfileView *profileView;
@property (nonatomic, strong) HotRecommendModel   *model;
//@property (nonatomic, strong) ZMHotInsetPostModel   *postModel;

#pragma mark - 根据布局来确定UI
- (void)setupUIWithRecommend:(itemStyle)style model:(HotRecommendModel *)model;

@end


//
//  WaterFlowLayout.h
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/20.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WaterFlowLayoutDelegate;

@interface WaterFlowLayout : UICollectionViewLayout

@property (nonatomic, weak) id<WaterFlowLayoutDelegate> delegate;
@property (nonatomic, copy) void(^updateHeight)(CGFloat);

@end

@protocol WaterFlowLayoutDelegate <NSObject>

@required
- (CGFloat)WaterFlowLayout:(WaterFlowLayout *)WaterFlowLayout heightForRowAtIndexPath:(NSInteger)index itemWidth:(CGFloat)itemWidth indexPath:(NSIndexPath *)indexPath;

@optional
- (CGFloat)columnCountInWaterflowLayout:(WaterFlowLayout *)waterflowLayout;
- (CGFloat)columnMarginInWaterflowLayout:(WaterFlowLayout *)waterflowLayout;
- (CGFloat)rowMarginInWaterflowLayout:(WaterFlowLayout *)waterflowLayout;
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(WaterFlowLayout *)waterflowLayout;

@end

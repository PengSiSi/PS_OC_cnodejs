//
//  TagsView.h
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/6.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TagsViewDelegate <NSObject>

-(void)TagsView:(UIView*)tagsView fetchWordToTextFiled:(NSString *)KeyWord;;

@end

@interface TagsView : UIView <UIGestureRecognizerDelegate>

{
    CGRect previousFrame;
    NSInteger totalHeight;
}

@property (nonatomic, weak) id<TagsViewDelegate> delegate;
/**
 *  整个View的背景颜色
 */
@property (nonatomic, strong) UIColor *BigBGColor;
/**
 *  设置子标签View的单一颜色
 */
@property (nonatomic, strong) UIColor *singleTagColor;
/**
 *  标签文本数组的赋值
 */
-(void)setTagWithTagArray:(NSArray *)arr;

@end

//
//  ContentView.h
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/20.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentView : UIView

/** 容器 */
@property (nonatomic, strong) UIView                *mainView;
/** 封面图 */
@property (nonatomic, strong) UIImageView           *thumbImageView;
/** top1 专属 icon */
@property (nonatomic, strong) UIImageView           *topImageView;
/** top1 专属 标致 */
@property (nonatomic, strong) UIButton              *topButton;
/** 底部渐变层 */
@property (nonatomic, strong) UIImageView           *bottomShadow;

@end

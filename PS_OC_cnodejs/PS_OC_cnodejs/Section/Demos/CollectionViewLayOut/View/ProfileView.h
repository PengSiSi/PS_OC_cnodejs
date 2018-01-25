//
//  ProfileView.h
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/20.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileView : UIView

@property (nonatomic, strong) UIView        *mainView;
@property (nonatomic, strong) UIImageView   *thumbImageView;
@property (nonatomic, strong) UILabel       *nameLabel;
@property (nonatomic, strong) UIButton      *praiseButton;
@property (nonatomic, copy) void(^praiseBlock)(BOOL); // 点赞

@end

//
//  LoginHeadrView.h
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/5.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginHeadrView : UIView

+ (LoginHeadrView *)loginHeadrView;

- (void)configureHeaderViewWithAvater: (NSString *)avaterImgStr nickName: (NSString *)nickNameStr registerTime: (NSString *)timeStr;

@end

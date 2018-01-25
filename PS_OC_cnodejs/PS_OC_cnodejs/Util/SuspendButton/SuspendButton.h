//
//  SuspendButton.h
//  QianfengSchool
//
//  Created by AlicePan on 16/7/12.
//  Copyright © 2016年 Combanc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuspendButton : UIButton

@property (copy, nonatomic) void(^suspendBtnClicked)();/**< 按钮点击事件*/

@end

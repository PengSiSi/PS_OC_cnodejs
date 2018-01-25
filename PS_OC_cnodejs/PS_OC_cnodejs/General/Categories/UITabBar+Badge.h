//
//  UITabBar+Badge.h
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/15.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (Badge)

- (void)showBadgeOnItemIndex:(int)index;
- (void)hideBadgeOnItemIndex:(int)index;

@end

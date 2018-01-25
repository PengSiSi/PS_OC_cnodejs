//
//  UITextView+Utils.h
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/19.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Utils)

// 设置行距
- (void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing;

// 设置行高
+ (CGFloat)text:(NSString*)text heightWithFontSize:(CGFloat)fontSize width:(CGFloat)width lineSpacing:(CGFloat)lineSpacing;

@end

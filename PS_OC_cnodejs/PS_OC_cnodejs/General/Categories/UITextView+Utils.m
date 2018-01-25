//
//  UITextView+Utils.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/19.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "UITextView+Utils.h"

@implementation UITextView (Utils)

- (void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing {
    if (lineSpacing < 0.01 || !text) {
        self.text = text;
        return;
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [text length])];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    
    self.attributedText = attributedString;
}

+ (CGFloat)text:(NSString*)text heightWithFontSize:(CGFloat)fontSize width:(CGFloat)width lineSpacing:(CGFloat)lineSpacing {
    UITextView* textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, width, MAXFLOAT)];
    textView.font = [UIFont systemFontOfSize:fontSize];
    [textView setText:text lineSpacing:lineSpacing];
    [textView sizeToFit];
    return textView.frame.size.height;
}

@end

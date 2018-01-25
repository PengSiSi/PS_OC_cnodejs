//
//  SearchBar.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/6.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "SearchBar.h"
#import "UIViewExt.h"

@implementation SearchBar

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.placeholder = @"搜索话题";
        //        [self setValue:LLColor(232, 178, 176) forKeyPath:@"_placeholderLabel.textColor"];
        self.layer.masksToBounds = YES;
        //        self.layer.cornerRadius  = 15;
        self.backgroundColor = [UIColor colorWithRed:236/255.0 green:237/255.0 blue:232/255.0 alpha:1];
        self.returnKeyType = UIReturnKeySearch;
        // 添加搜索图
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"搜索-拷贝"]];
        imgView.contentMode = UIViewContentModeCenter;
        imgView.width += 30;
        self.leftView = imgView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.returnKeyType = UIReturnKeySearch;
    }
    return self;
}

+ (instancetype)searchBar {
    
    return [[self alloc] init];
}

@end

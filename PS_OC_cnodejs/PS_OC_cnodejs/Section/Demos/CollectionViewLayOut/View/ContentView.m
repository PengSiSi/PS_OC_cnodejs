//
//  ContentView.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/20.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "ContentView.h"

@implementation ContentView

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [UIView new];
        _mainView.layer.masksToBounds = YES;
        [self addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        [_mainView.superview layoutIfNeeded];
    }
    return _mainView;
}

- (UIImageView *)thumbImageView{
    if (!_thumbImageView) {
        _thumbImageView = [[UIImageView alloc] init];
        _thumbImageView.layer.masksToBounds = YES;
        [self.mainView addSubview:_thumbImageView];
        [self.mainView sendSubviewToBack:_thumbImageView];
        [_thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        [_thumbImageView.superview layoutIfNeeded];
    }
    return _thumbImageView;
}

- (UIImageView *)topImageView{
    if (!_topImageView) {
        _topImageView = [UIImageView new];
        UIImage *image = [UIImage imageNamed:@"double_line_one"];
        _topImageView.image = image;
        [self.mainView addSubview:_topImageView];
        [_topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(10);
            make.size.mas_equalTo(image.size);
        }];
    }
    return _topImageView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end

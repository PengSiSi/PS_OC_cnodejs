//
//  ProfileView.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/20.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "ProfileView.h"

@implementation ProfileView

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [UIView new];
        [self addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        [_mainView.superview layoutIfNeeded];
    }
    return _mainView;
}

- (UIImageView *)thumbImageView{
    if (!_thumbImageView) {
        _thumbImageView = [[UIImageView alloc] init];
        _thumbImageView.layer.masksToBounds = YES;
        _thumbImageView.contentMode = UIViewContentModeScaleAspectFit;
        UIImage *image = [UIImage imageNamed:@"discovery_search_user"];
        //_thumbImageView.size = CGSizeMake(20, 20);
        _thumbImageView.layer.cornerRadius = (image.size.width+5) * 0.5;
        [self.mainView addSubview:_thumbImageView];
        [self.mainView sendSubviewToBack:_thumbImageView];
        [_thumbImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.centerY.mas_equalTo(self.mainView);
            make.size.mas_equalTo(CGSizeMake(image.size.width+5, image.size.width+5));
        }];
        [_thumbImageView.superview layoutIfNeeded];
    }
    return _thumbImageView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:13];
        [self.mainView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.thumbImageView.mas_right).with.offset(10);
            make.right.mas_equalTo(self.praiseButton.mas_left).with.offset(-5);
            make.centerY.mas_equalTo(self.mainView);
        }];
    }
    return _nameLabel;
}

- (UIButton *)praiseButton{
    if (!_praiseButton) {
        _praiseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _praiseButton.userInteractionEnabled = YES;
        [_praiseButton setImage:[UIImage imageNamed:@"ill_cos_like"] forState:UIControlStateNormal];
        [_praiseButton setImage:[UIImage imageNamed:@"ill_cos_liked"] forState:UIControlStateSelected];
        [self.mainView addSubview:_praiseButton];
        
        [_praiseButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.centerY.mas_equalTo(self.mainView.mas_centerY);
        }];
        [_praiseButton addTarget:self action:@selector(clickPraiseButton:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _praiseButton;
}

#pragma mark - private - TouchUpInSide
- (void)clickPraiseButton:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (self.praiseBlock) {
        self.praiseBlock(btn.selected);
    }
}

@end

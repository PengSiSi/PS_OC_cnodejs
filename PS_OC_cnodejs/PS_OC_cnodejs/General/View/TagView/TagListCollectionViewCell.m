//
//  TagListCollectionViewCell.m
//  changpingSchoolTeacher
//
//  Created by 王楠 on 16/9/4.
//  Copyright © 2016年 combanc. All rights reserved.
//

#import "TagListCollectionViewCell.h"

@implementation TagListCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 8.0f;
    self.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.contentView.layer.borderWidth = 0.4f;
    
    self.bgImgV = [[UIImageView alloc] init];
    self.bgImgV.backgroundColor = [UIColor whiteColor];
    // Center
    self.bgImgV.contentMode = UIViewContentModeRedraw;
    [self.contentView addSubview:self.bgImgV];
    [self.bgImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    self.tagLabel = [[UILabel alloc] init];
    self.tagLabel.textAlignment = NSTextAlignmentLeft;
    self.tagLabel.font = FONT_13;
    [self.contentView addSubview:self.tagLabel];
    
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self.contentView);
//        make.centerY.equalTo(self.contentView.mas_centerY);
//        make.left.equalTo(self.contentView.mas_left).offset(5);
    }];
}

- (void)setBgImg:(UIImage *)bgImg {
//    self.bgImgV.backgroundColor = [UIColor colorWithPatternImage:bgImg];
    self.bgImgV.image = bgImg;
}

@end

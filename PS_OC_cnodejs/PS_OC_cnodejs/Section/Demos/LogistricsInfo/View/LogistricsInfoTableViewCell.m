//
//  LogistricsInfoTableViewCell.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2018/1/2.
//  Copyright © 2018年 思 彭. All rights reserved.
//

#import "LogistricsInfoTableViewCell.h"

@interface LogistricsInfoTableViewCell() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *iconImgView;

@end

@implementation LogistricsInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
        [self layoutContraints];
        [self testUI];
    }
    return self;
}

- (void)createSubViews {
    self.iconImgView = [[UIImageView alloc]init];
    self.iconImgView.layer.cornerRadius = 10;
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = [UIColor lightGrayColor];
    self.infoLabel = [[UILabel alloc]init];
    self.infoLabel.textColor = [UIColor grayColor];
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.textColor = [UIColor lightGrayColor];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(50, 50);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.scrollEnabled = NO;
    // 注册cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
    
    [self.contentView addSubview:self.iconImgView];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.infoLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.collectionView];
}

- (void)layoutContraints {
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(20);
        make.left.top.mas_equalTo(10);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(self.iconImgView.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self.iconImgView);
        make.bottom.mas_equalTo(self.contentView).offset(-10);
    }];
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.iconImgView.mas_right).offset(10);
        make.top.mas_equalTo(self.contentView).offset(10);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(-10);
        make.left.mas_equalTo(self.infoLabel);
        make.top.mas_equalTo(self.infoLabel.mas_bottom).offset(10);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.infoLabel);
        make.top.mas_equalTo(self.timeLabel.mas_bottom).offset(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(self.contentView).offset(-10);
    }];
}

- (void)testUI {
    self.iconImgView.backgroundColor = [UIColor redColor];
    self.lineView.backgroundColor = [UIColor lightGrayColor];
    self.infoLabel.text = @"客服正在紧急处理，请稍等";
    self.timeLabel.text = @"2018年1月2日  10:28";
    self.collectionView.backgroundColor = [UIColor clearColor];
}

// 赋值
- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    [self updateCollectionContraint];
    [self.collectionView reloadData];
}

// 更新collectionView约束
- (void)updateCollectionContraint {
    // 行数
    NSInteger rows;
    if (self.dataArray.count < 6) {
        rows = 1;
    }
    else if (self.dataArray.count > 5 && self.dataArray.count < 11) {
        rows = 2;
    } else {
        rows = 3;
    }
    // 列数
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo((rows * 50) + (rows * 10));
    }];
    [self.lineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.collectionView).offset(-10);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

@end

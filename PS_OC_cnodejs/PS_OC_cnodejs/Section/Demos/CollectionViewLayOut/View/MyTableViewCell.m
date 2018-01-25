//
//  MyTableViewCell.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/20.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "MyTableViewCell.h"
#import "UIViewExt.h"

#define HttpImageURLPre @"https://gacha.nosdn.127.net/"


@interface MyTableViewCell() <UICollectionViewDataSource,WaterFlowLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundView.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        WaterFlowLayout *layout = [[WaterFlowLayout alloc]init];
        __weak typeof(self) weakSelf = self;
        layout.updateHeight = ^(CGFloat height){
            if (height != weakSelf.cacheHeight && self.updateCellHeight) {
                weakSelf.cacheHeight = height;
                weakSelf.updateCellHeight(height);
            }
        };
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        [_collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"water"];
        layout.delegate = self;
        [self.contentView addSubview:_collectionView];
    }
    return _collectionView;
}

- (void)setDataArray:(NSArray *)dataArray{
    if (!dataArray.count) return;
    _dataArray = dataArray;
    
    if (self.collectionView.height != self.cacheHeight || self.needUpdate) {
        self.collectionView.height = self.cacheHeight;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            self.needUpdate = NO;
        });
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"water" forIndexPath:indexPath];
    [cell setupUIWithRecommend:self.style model:self.dataArray[indexPath.item]];
    return cell;
}

#pragma mark - WaterFlowLayoutDelegate
- (CGFloat)WaterFlowLayout:(WaterFlowLayout *)WaterFlowLayout heightForRowAtIndexPath:(NSInteger )index itemWidth:(CGFloat)itemWidth indexPath:(NSIndexPath *)indexPath{
    HotRecommendModel *model = self.dataArray[index];
    if (self.style == itemStyleSingle) {
        return model.realHeight + 40;
    }
    return model.realHeight / 2;
}

- (CGFloat)columnCountInWaterflowLayout:(WaterFlowLayout *)waterflowLayout{
    if (self.style == itemStyleSingle) {
        return 1;
    }
    return 2;
}
- (CGFloat)columnMarginInWaterflowLayout:(WaterFlowLayout *)waterflowLayout{
    if (self.style == itemStyleSingle) {
        return 0;
    }
    return 2;
}

- (CGFloat)rowMarginInWaterflowLayout:(WaterFlowLayout *)waterflowLayout{
    if (self.style == itemStyleSingle) {
        return 10;
    }
    return 2;
}

- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(WaterFlowLayout *)waterflowLayout{
    if (self.style == itemStyleSingle) {
        return UIEdgeInsetsMake(2, 0, 2, 0);
    }
    return UIEdgeInsetsMake(0, 0, 5, 0);
}

@end

@implementation MyCollectionViewCell

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [UIView new];
        _mainView.userInteractionEnabled = YES;
        [self.contentView addSubview:_mainView];
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
        [_mainView.superview layoutIfNeeded];
    }
    return _mainView;
}

- (ContentView *)view{
    if (!_view) {
        _view = [[ContentView alloc] init];
        [self.mainView addSubview:_view];
        [self.mainView sendSubviewToBack:_view];
        [_view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(0);
        }];
    }
    return _view;
}

- (ProfileView *)profileView{
    if (!_profileView) {
        _profileView = [[ProfileView alloc] init];
        _profileView.userInteractionEnabled = YES;
        [self.mainView addSubview:_profileView];
        [self.mainView bringSubviewToFront:_profileView];
        [_profileView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(40);
        }];
        [_profileView.superview layoutIfNeeded];
    }
    return _profileView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        //        [self view];
        //        [self profileView];
    }
    return self;
}

- (void)setupUIWithRecommend:(itemStyle)style model:(HotRecommendModel *)model{
    if (!model) return;
    _model = model;
    self.profileView.praiseButton.selected = model.hasPraise;
    self.profileView.praiseBlock = ^(BOOL selected){
        model.hasPraise = selected;
        NSLog(@"点赞 = %d",selected);
    };
    if (model.top == 1) {
        self.view.topImageView.hidden = NO;
    }else{
        self.view.topImageView.hidden = YES;
    }
    UIImage *image = [UIImage imageNamed:@"discovery_search_user"];
    if (style == itemStyleSingle) {
        if (model.top == 1) {
            self.view.topButton.hidden = NO;
        }
        self.view.bottomShadow.hidden = NO;
        
        self.profileView.backgroundColor = [UIColor clearColor];
        self.profileView.thumbImageView.layer.cornerRadius = 25 * 0.5;
        [self.profileView.thumbImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(25);
        }];
//        [self.profileView.thumbImageView setImageWithURL:[NSURL URLWithString:model.author.portraitFullUrl] placeholder:placeholderAvatarImage];
//        self.profileView.nameLabel.textColor = [ZMColor whiteColor];
//        self.profileView.nameLabel.text = model.author.nickName;
        self.profileView.thumbImageView.backgroundColor = [UIColor redColor];
        self.profileView.nameLabel.text = @"思思";
        self.profileView.nameLabel.textColor = [UIColor grayColor];
        
    }else{
        self.view.topButton.hidden = YES;
        self.view.bottomShadow.hidden = YES;
        self.profileView.thumbImageView.backgroundColor = [UIColor clearColor];
        self.profileView.backgroundColor = [UIColor whiteColor];
        self.profileView.thumbImageView.image = image;
        self.profileView.thumbImageView.layer.cornerRadius = 0;
        [self.profileView.thumbImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(image.size);
        }];
        self.profileView.nameLabel.text = @"思思";
        self.profileView.nameLabel.textColor = [UIColor grayColor];
        
    }
    //2倍宽高图片质量会变大！！！wifi
    NSString *string = [NSString stringWithFormat:@"%@%@?imageView&axis_5_5&enlarge=1&quality=75&thumbnail=%.0fy%.0f&type=webp",HttpImageURLPre,model.imgId,model.realWidth * 2,model.realHeight * 2 + 40];
//    self.view.thumbImageView.backgroundColor = [UIColor redColor];
    // 返回图片不显示，估计是图片url有问题，这里先写死了
    [self.view.thumbImageView sd_setImageWithURL:[NSURL URLWithString:@"http://img.woyaogexing.com/2017/03/02/a3ec8c4ffe9ec3ae!600x600.jpg"]];
}

@end


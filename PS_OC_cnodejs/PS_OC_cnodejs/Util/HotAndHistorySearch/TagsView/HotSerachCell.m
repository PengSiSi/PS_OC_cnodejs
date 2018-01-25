//
//  HotSerachCell.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/6.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "HotSerachCell.h"

@implementation HotSerachCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.tagsView = [[TagsView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width - 20, 0)];
        self.tagsView.singleTagColor = RGBA(123, 133, 164, 1);
        self.contentView.userInteractionEnabled = YES;
        [self.contentView addSubview:self.tagsView];
    }
    return self;
}

- (void)setHotSearchArr:(NSArray *)hotSearchArr {
    
    _hotSearchArr = hotSearchArr;
    
    /** 注意cell的subView的重复创建！（内部已经做了处理了......） */
    [self.tagsView setTagWithTagArray:hotSearchArr];
    
}

@end

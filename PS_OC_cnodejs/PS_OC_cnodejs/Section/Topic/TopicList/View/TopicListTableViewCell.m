//
//  TopicListTableViewCell.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/5.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "TopicListTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface TopicListTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avaterImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *createDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastReplyLabel;

@end

@implementation TopicListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // 标题加粗
    [self.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    [self.avaterImgView roundedRectImageViewWithCornerRadius:25.0];
}

- (void)setModel:(HomeTopicModel *)model {
    self.titleLabel.text = model.title;
    self.nickNameLabel.text = model.author.loginname;
    [self.avaterImgView sd_setImageWithURL:[NSURL URLWithString:model.author.avatar_url] placeholderImage:nil];
    NSString *countStr = [NSString stringWithFormat:@"%ld/%ld", model.reply_count, model.visit_count];
    // 拆分设置颜色
//    NSArray *array = [countStr componentsSeparatedByString:@"/"];
//    self.countLabel.attributedText = [self getAttributedString:array.firstObject withString:array.lastObject];
}

- (NSMutableAttributedString *)getAttributedString:(NSString *)string
                                        withString:(NSString *)string2 {
    
    
    NSMutableAttributedString *mutableAttribute = [[NSMutableAttributedString alloc]init];
    NSAttributedString *string0 = [NSString getAttributedString:string withcolor:GREEN_COLOR withFont:[UIFont fontWithName:@"PingFang-SC-Regular" size:15]];
    NSAttributedString *string1 = [NSString getAttributedString:string2 withcolor:[UIColor darkGrayColor] withFont:[UIFont fontWithName:@"PingFang-SC-Regular" size:15]];
    [mutableAttribute appendAttributedString:string0];
    [mutableAttribute appendAttributedString:string1];
    return mutableAttribute;
}


@end

//
//  ReplyTableViewCell.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/6.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "ReplyTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface ReplyTableViewCell() <CAAnimationDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *avaterImgView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

- (IBAction)likeButtonAction:(id)sender;

@end

@implementation ReplyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.avaterImgView roundedRectImageViewWithCornerRadius:25.0f];
}

- (IBAction)likeButtonAction:(id)sender {
    self.likeButton.selected = !self.likeButton.selected;

    // 简单的点赞动画---关键帧动画
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    animation.delegate = self;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    
    animation.values = values;
    [self.likeButton.layer addAnimation:animation forKey:nil];
    if (self.block) {
        self.block(self.indexPath);
    }
}

- (void)configureCellAvaterUrl: (NSString *)url nickName: (NSString *)name date: (NSString *)dateStr likeCount: (NSString *)count content: (NSString *)content is_uped: (BOOL)is_uped {
    [self.avaterImgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:nil];
    self.nickNameLabel.text = name;
    self.dateLabel.text = dateStr;
    self.likeCountLabel.text = count;
    self.contentLabel.text = [NSString filterHTML:content];
    [self.likeButton setTitle:count forState:UIControlStateNormal];
    if (is_uped) {
//        self.likeButton.selected = YES;
//        [self.likeButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    } else {
//        self.likeButton.selected = NO;
//        [self.likeButton setImage:[UIImage imageNamed:@"liked"] forState:UIControlStateNormal];
    }
}

@end

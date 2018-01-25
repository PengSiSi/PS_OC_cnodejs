//
//  NoLoginHeaderView.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/5.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "NoLoginHeaderView.h"

@interface NoLoginHeaderView()

@property (weak, nonatomic) IBOutlet UIImageView *avaterImgView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;

@end

@implementation NoLoginHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nickNameLabel.userInteractionEnabled = YES;
    // nickNameLabel添加手势登录
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpLoginAction)];
    [self.nickNameLabel addGestureRecognizer:tap];
}

+ (NoLoginHeaderView *)noLoginHeadrView {
    return [[NSBundle mainBundle] loadNibNamed:@"NoLoginHeaderView" owner:nil options:nil].lastObject;
}

- (void)jumpLoginAction {
    if (self.tapBlock) {
        self.tapBlock();
    }
}
@end

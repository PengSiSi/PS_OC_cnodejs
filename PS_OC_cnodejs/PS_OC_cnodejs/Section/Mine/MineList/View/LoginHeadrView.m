//
//  LoginHeadrView.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/5.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "LoginHeadrView.h"
#import <UIImageView+WebCache.h>
#import "UIImageView+Extend.h"

@interface LoginHeadrView()
@property (weak, nonatomic) IBOutlet UIImageView *avaterImgView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *registerTimeLabel;

@end

@implementation LoginHeadrView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.avaterImgView roundedRectImageViewWithCornerRadius:30];
}

+ (LoginHeadrView *)loginHeadrView {

    return [[NSBundle mainBundle] loadNibNamed:@"LoginHeadrView" owner:nil options:nil].lastObject;
}

- (void)configureHeaderViewWithAvater: (NSString *)avaterImgStr nickName: (NSString *)nickNameStr registerTime: (NSString *)time {
    [self.avaterImgView sd_setImageWithURL:[NSURL URLWithString:avaterImgStr] completed:nil];
    self.nickNameLabel.text = nickNameStr;
    // 处理数据 2017-11-28T02:41:09.487Z
    // 请求的时间戳。日期格式按照ISO8601标准表示，并需要使用UTC时间。
    // 去掉.之后的字符串
    NSArray *strArray = [time componentsSeparatedByString:@"."];
    // 字符串转date
    NSDate *registerDate = [NSString dateFromString:[NSString stringWithFormat:@"%@Z",strArray[0]]];
    // 对ISO8601标准时间date转String
    NSString *str = [NSString timeStamp:registerDate];
    // 对ISO8601标准时间String转时间间隔
    NSString *str1 = [NSString JudgmentTimeIntervalWithISOTime:str];
    NSLog(@"registerDate = %@", [NSString compareCurrentTime:str1]);
    self.registerTimeLabel.text = [NSString stringWithFormat:@"注册于：%@", [NSString compareCurrentTime:str1]];
}

@end

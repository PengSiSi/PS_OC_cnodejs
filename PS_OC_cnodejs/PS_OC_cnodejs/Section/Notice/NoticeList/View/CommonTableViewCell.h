//
//  CommonTableViewCell.h
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/5.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgIcon;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iConImgView;

- (void)configureCellWithImage: (NSString *)imgStr title: (NSString *)titleStr;

@end

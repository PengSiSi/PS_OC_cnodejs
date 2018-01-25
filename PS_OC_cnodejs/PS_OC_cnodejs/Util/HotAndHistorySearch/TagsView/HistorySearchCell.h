//
//  HistorySearchCell.h
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/6.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistorySearchCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *tipIconImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *removeButton;

- (IBAction)removeAction:(id)sender;

@end

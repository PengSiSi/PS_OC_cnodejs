//
//  NoLoginHeaderView.h
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/5.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoLoginHeaderView : UIView

@property (nonatomic, copy) dispatch_block_t tapBlock;

+ (NoLoginHeaderView *)noLoginHeadrView;

@end

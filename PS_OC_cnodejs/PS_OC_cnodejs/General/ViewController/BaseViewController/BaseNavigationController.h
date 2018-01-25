//
//  BaseNavigationController.h
//  Ssdfz
//
//  Created by 王楠 on 16/1/20.
//  Copyright © 2016年 Combanc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface BaseNavigationController : UINavigationController

@property (nonatomic, strong) NSString *backBtnTitle; /**< 返回按钮的名*/
@property (nonatomic, assign) BOOL backBtnImgWhite; /**< 返回按钮是否是白色*/

@end

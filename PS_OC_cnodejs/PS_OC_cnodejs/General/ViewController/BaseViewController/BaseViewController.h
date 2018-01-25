//
//  BaseViewController.h
//  changpingSchoolTeacher
//
//  Created by 王楠 on 16/1/19.
//  Copyright © 2016年 Combanc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BackButtonHandlerProtocol <NSObject>
@optional
// Override this method in UIViewController derived class to handle 'Back' button click
-(BOOL)navigationShouldPopOnBackButton;
@end

@interface BaseViewController : UIViewController <BackButtonHandlerProtocol>

@end

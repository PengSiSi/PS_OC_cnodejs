//
//  CountDownButton.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2018/1/23.
//  Copyright © 2018年 思 彭. All rights reserved.
//

#import "CountDownButton.h"

@implementation CountDownButton

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}

- (void)refreshUI
{
    dispatch_source_cancel(_timer);
    self.enabled = YES;
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
}

dispatch_source_t _timer ;
// 开启倒计时效果
-(void)openCountdown{
    
    // 需要初始化
    [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    self.enabled = YES;
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self setTitle:@"获取验证码" forState:UIControlStateNormal];
                self.enabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self setTitle:[NSString stringWithFormat:@"%d秒后重试", seconds] forState:UIControlStateNormal];
                
                self.enabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
}

@end

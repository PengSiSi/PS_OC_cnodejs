//
//  AppUpdater.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2018/2/5.
//  Copyright © 2018年 思 彭. All rights reserved.
//

#import "AppUpdater.h"

@interface AppUpdater()

@property (nonatomic ,strong) NSURL *updateUrl;

@end

@implementation AppUpdater

+ (AppUpdater *)shareInstance {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (void)checkUpdate {
    NSString *urlString = [NSString stringWithFormat:@"%@",@""];
    // 数据请求
    [HTTPTool getWithURL:urlString headers:nil params:nil success:^(id json) {
        if ([json[@"status"] integerValue] == 200) {
            NSString *lowestVersionName = json[@"Data"][@"lowestVersionName"];
            NSString *lowestVersion = [lowestVersionName stringByReplacingOccurrencesOfString:@"."withString:@""];
            NSString *versionName = json[@"Data"][@"versionName"];
            NSString *version = [versionName stringByReplacingOccurrencesOfString:@"."withString:@""];
            NSString *currentVersionName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
            NSString *currentVersion = [currentVersionName stringByReplacingOccurrencesOfString:@"."withString:@""];
            NSLog(@"%f",[currentVersion floatValue]);
            self.updateUrl = json[@"Data"][@"url"];
            
            //当前版本小于最低版本则强制更新
            if ([currentVersion floatValue] < [lowestVersion floatValue]) {
                
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"已发现新版本，只有更新到最新版本才能更好的为您提供优质便捷的服务" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [[UIApplication sharedApplication] openURL:self.updateUrl];
                }];
                [alertVC addAction:okAction];
                
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
            }else if([currentVersion floatValue] < [version floatValue]){
                //选择更新
                
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"发现新版本，是否更新" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [[UIApplication sharedApplication] openURL:self.updateUrl];
                }];
                
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                
                [alertVC addAction:okAction];
                [alertVC addAction:cancelAction];
                
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"error = %@", error.description);
    }];
}

@end

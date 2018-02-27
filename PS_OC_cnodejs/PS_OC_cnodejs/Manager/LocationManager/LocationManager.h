//
//  LocationManager.h
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2018/2/5.
//  Copyright © 2018年 思 彭. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LocationManager;

@protocol LocationManagerDelegate <NSObject>

-(void)locationManager:(LocationManager *)locationManager didGotLocation:(NSString *)location;

@end

@interface LocationManager : NSObject

@property (nonatomic, assign) id<LocationManagerDelegate> delegate;

// 单例模式实例化对象
+ (LocationManager *)sharedInstance;

// 开始定位
- (void)autoLocate;

@end

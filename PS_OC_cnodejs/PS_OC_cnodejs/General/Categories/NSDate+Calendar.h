//
//  NSDate+Calendar.h
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/14.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Calendar)

- (NSDateComponents *)deltaFrom:(NSDate *)from;
- (BOOL)isThisYear;
- (BOOL)isToday;
- (BOOL)isYesterday;

@end

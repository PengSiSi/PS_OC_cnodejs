//
//  UIImage+Extend.h
//  BeijingPrimarySchoolTZBranch
//
//  Created by 王楠 on 16/9/9.
//  Copyright © 2016年 Combanc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extend)

- (UIImage *)fixOrientation:(UIImage *)anImage;
+ (UIImage *)fixOrientation:(UIImage *)anImage;
- (UIImage *)imageByTintColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor*) color;

+ (UIImage *)imageOriginalWithName:(NSString *)imageName;
- (instancetype)circleImage;
+ (instancetype)circleImageNamed:(NSString *)name;
+ (UIImage *)imageWithColor:(UIColor *)color andRect:(CGRect )rect;
+ (instancetype)circleImageNamed:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
- (instancetype)circleImageBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
@end

//
//  HTTPTool.m
//  GeneralProject
//
//  Created by 王楠 on 16/1/18.
//  Copyright © 2016年 王楠. All rights reserved.
//

#import "HTTPTool.h"
#import <AFHTTPSessionManager.h>

#define TIMEOUTINTERVAL 30

@implementation HTTPTool

#pragma mark - GET

+ (void)getWithURL:(NSString *)url headers:(NSDictionary *)headers params:(NSDictionary *)params success:(HttpSuccess)success failure:(HttpFailure)failure {
    [self requestWithType:@"GET" url:url headers:headers params:params success:success failure:failure];
}

#pragma mark - POST

+ (void)postWithURL:(NSString *)url headers:(NSDictionary *)headers params:(NSDictionary *)params success:(HttpSuccess)success failure:(HttpFailure)failure {
    [self requestWithType:@"POST" url:url headers:headers params:params success:success failure:failure];
}

+ (void)requestWithType:(NSString *)type url:(NSString *)url headers:(NSDictionary *)headers params:(NSDictionary *)params success:(HttpSuccess)success failure:(HttpFailure)failure {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    manager.requestSerializer.timeoutInterval = TIMEOUTINTERVAL;
    //设置请求头
    if (headers != nil) {
        for (id httpHeaderField in headers.allKeys) {
            id value = headers[httpHeaderField];
            if ([httpHeaderField isKindOfClass:[NSString class]] && [value isKindOfClass:[NSString class]]) {
                [manager.requestSerializer setValue:(NSString *)value forHTTPHeaderField:(NSString *)httpHeaderField];
            }else{
                NSLog(@"Error, class of key/value in headerFieldValueDictionary should be NSString.");
            }
        }
    }
    
    if ([type isEqualToString:@"GET"]) {
        [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            // 请求成功的时候会调用这里的代码
            // 通知外面的block，请求成功了
            if (success) {
                id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                success(json);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // 请求失败的时候会调用这里的代码
            // 通知外面的block，请求失败了
            if (failure) {
                failure(error);
            }
        }];
    }else if ([type isEqualToString:@"POST"]){
        [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            // 请求成功的时候会调用这里的代码
            // 通知外面的block，请求成功了
            if (success) {
                id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                success(json);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // 请求失败的时候会调用这里的代码
            // 通知外面的block，请求失败了
            if (failure) {
                failure(error);
            }
        }];
    }
}

/**
 *  异步POST请求:以body方式,支持数组
 *
 *  @param url     请求的url
 *  @param body    body数据
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)postWithUrl:(NSString *)url body:(NSData *)body success:(HttpSuccess)success failure:(HttpSuccess)failure {
        
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:nil error:nil];
    request.timeoutInterval = TIMEOUTINTERVAL;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    // 设置body
    [request setHTTPBody:body];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            failure(error);
        } else {
            id json = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            success(json);
        }
    }] resume];
}

+ (NSURL *)writeImageToFile:(UIImage *)image imageName:(NSString *)imageName{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *tempPath = NSTemporaryDirectory();
    NSString *upLoadFilePath = [tempPath stringByAppendingPathComponent:[NSString stringWithFormat:@"upLoadFile"]];
    if([fileManager fileExistsAtPath:upLoadFilePath]){
    }else{
        //创建路径
        [fileManager createDirectoryAtPath:upLoadFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSData *data = [[NSData alloc] init];
    if ([image isKindOfClass:[NSString class]]) {
        data = [NSData dataWithContentsOfURL:[NSURL URLWithString:(NSString *)image]];
    }else{
        
        if (UIImagePNGRepresentation(image) == nil) {
            data = UIImageJPEGRepresentation(image, 0.2);
        } else {
            data = [self compressImage:image];
        }
    }
    //创建文件
    if (data) {
        
        [fileManager createFileAtPath:[upLoadFilePath stringByAppendingString:[NSString stringWithFormat:@"/%@",imageName]] contents:data attributes:nil];
    }
    
    //根据路径得到URL
    NSString *thumbUrl = [NSString stringWithFormat:@"%@/%@",upLoadFilePath,imageName];
    //写入文件
    [data writeToFile:thumbUrl atomically:YES];
    NSURL *imgUrl = [NSURL fileURLWithPath:thumbUrl];
    
    return imgUrl;
}

+ (NSData *)compressImage:(UIImage *)image {
    NSUInteger maxFileSize = FILE_MAXSIZE;
    NSData *originImageData = UIImagePNGRepresentation(image);
    NSInteger length = [originImageData length]/1024;
    if (length < maxFileSize) {
        return originImageData;
    } else {
        CGFloat compressionRatio = 0.7f;
        CGFloat maxCompressionRatio = 0.1f;
        NSData *imageData = UIImageJPEGRepresentation(image, compressionRatio);
        
        while (imageData.length > maxFileSize && compressionRatio > maxCompressionRatio) {
            compressionRatio -= 0.1f;
            imageData = UIImageJPEGRepresentation(image, compressionRatio);
        }
        return imageData;
    }
}

@end

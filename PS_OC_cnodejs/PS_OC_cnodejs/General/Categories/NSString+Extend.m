//
//  NSString+Extend.m
//  Ssdfz
//
//  Created by 王楠 on 16/5/13.
//  Copyright © 2016年 Combanc. All rights reserved.
//

#import "NSString+Extend.h"
#import <CommonCrypto/CommonDigest.h>
#import <Foundation/Foundation.h>

@implementation NSString (Extend)

NSString *const saveFilePath = @"uploadPhoto";

+ (NSString *)md5String:(NSString *)string {
    const char *cStr = [string UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font space:(CGFloat)space {
    CGRect rect = [string boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - space, 90000)//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    return rect.size;
}

+ (CGSize)sizeWithString:(NSString *)string font:(UIFont *)font maxSize:(CGSize) maxSize {
    CGRect rect = [string boundingRectWithSize:maxSize//限制最大的宽度和高度
                                       options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    return rect.size;
}


//过滤表情
+ (NSString *)filterEmoji:(NSString *)string {
    NSUInteger len = [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    const char *utf8 = [string UTF8String];
    char *newUTF8 = malloc( sizeof(char) * len );
    int j = 0;
    
    //0xF0(4) 0xE2(3) 0xE3(3) 0xC2(2) 0x30---0x39(4)
    for ( int i = 0; i < len; i++ ) {
        unsigned int c = utf8;
        BOOL isControlChar = NO;
        if ( c == 4294967280 ||
            c == 4294967089 ||
            c == 4294967090 ||
            c == 4294967091 ||
            c == 4294967092 ||
            c == 4294967093 ||
            c == 4294967094 ||
            c == 4294967095 ||
            c == 4294967096 ||
            c == 4294967097 ||
            c == 4294967088 ) {
            i = i + 3;
            isControlChar = YES;
        }
        if ( c == 4294967266 || c == 4294967267 ) {
            i = i + 2;
            isControlChar = YES;
        }
        if ( c == 4294967234 ) {
            i = i + 1;
            isControlChar = YES;
        }
        if ( !isControlChar ) {
            newUTF8[j] = utf8;
            j++;
        }
    }
    newUTF8[j] = '\0';
    NSString *encrypted = [NSString stringWithCString:(const char*)newUTF8
                                             encoding:NSUTF8StringEncoding];
    free( newUTF8 );
    return encrypted;
}

//是否含有表情
+ (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

//检测输入的汉字数 （汉字占 2位 表情占 4位 其余占1位）
+ (NSInteger)stringCount:(NSString*)string {
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* da = [string dataUsingEncoding:enc];
    return [da length];
}

+ (NSString *)saveImage:(NSData *)imageData imageName:(NSString *)imageName {
    NSString *resultPath;

    //    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *tempPath = NSTemporaryDirectory();
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *testDirectory = [tempPath stringByAppendingPathComponent:saveFilePath];
    // 创建目录
    [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    //创建文件
    if (imageData) {
        resultPath = [testDirectory stringByAppendingString:[NSString stringWithFormat:@"/%@",imageName]];
        [fileManager createFileAtPath:resultPath contents:imageData attributes:nil];
    }
    NSLog(@"resultPath-----:%@",resultPath);
    return resultPath;
}

+ (void)deleteTemSaveImageWithFilePath:(NSString *)imageName {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *tempPath = NSTemporaryDirectory();
    NSString *testDirectory = [tempPath stringByAppendingPathComponent:saveFilePath];
    NSString *resultPath = [testDirectory stringByAppendingString:[NSString stringWithFormat:@"/%@",imageName]];    
    // 删除文件/文件夹
    [fileManager removeItemAtPath:resultPath error:nil];
}

+ (NSAttributedString *)htmlDetailContentWithText:(NSString *)text {
    NSString *htmlStr = [NSString stringWithFormat:@"<html><body>%@<body/><html>", text];
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    return attrStr;
}

- (NSString *)stringByTrim {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

+ (NSString *)characterSet1:(NSString *)string {
    
    NSCharacterSet *characterSet1 = [NSCharacterSet characterSetWithCharactersInString:@"<p/brh>"];
    // 将string1按characterSet1中的元素分割成数组
    NSArray *array1 = [string componentsSeparatedByCharactersInSet:characterSet1];
    
    for(NSString *string1 in array1) {
        if ([string1 length]>0) {
            // 此处string即为中文字符串
            return string1;
        }
    }
    return string;
}

+ (NSString *)convertTimeString:(NSString *)timeStr {
    NSString *resultStr = @"";
    if (timeStr.length == 0) {
        return resultStr;
    }
    if ([timeStr componentsSeparatedByString:@"."].count > 0) {
        timeStr = [timeStr componentsSeparatedByString:@"."].firstObject;
        timeStr = [timeStr componentsSeparatedByString:@" "].firstObject;
    }
    // 获取系统时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setTimeZone:zone]; //设置时区
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *send = [fmt dateFromString:timeStr];

//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSDateComponents *comps = [calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit) fromDate:send];
//    NSDateComponents *comp = [calendar components:(NSCalendarUnitWeekOfMonth) fromDate:send];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"MM月dd日，EEEE"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    resultStr = [dateFormatter stringFromDate:send];
    return resultStr;
}

+ (BOOL)whetherBeforeTime:(NSString *)timeStr {
    BOOL b = false;
    if (timeStr.length == 0) {
        return @"";
    }
    if ([timeStr componentsSeparatedByString:@"."].count > 0) {
        timeStr = [timeStr componentsSeparatedByString:@"."].firstObject;
    }
    
    // 获取系统时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setTimeZone:zone]; //设置时区
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *send = [fmt dateFromString:timeStr];
    NSDate *now = [NSDate date];
    
    // 获得时间的间隔
    NSTimeInterval delta = [now timeIntervalSinceDate:send];
    if (delta > 0) {
        b = true;
    }else {
        b = false;
    }
    return b;
}

+ (NSString *)deltaTime:(NSString *)timeStr {
    if (timeStr.length == 0) {
        return @"";
    }
    if ([timeStr componentsSeparatedByString:@"."].count > 0) {
        timeStr = [timeStr componentsSeparatedByString:@"."].firstObject;
    }
    
    // 获取系统时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setTimeZone:zone]; //设置时区
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *send = [fmt dateFromString:timeStr];
    NSDate *now = [NSDate date];
    
    // 获得时间的间隔
    NSString *resultTimeStr = nil;
    NSTimeInterval delta = [now timeIntervalSinceDate:send];
    if (delta < 60) { // 一分钟内
        resultTimeStr = @"刚刚";
    } else if (delta < 60 * 60) { // 一个小时内
        resultTimeStr = [NSString stringWithFormat:@"%.f分钟前", delta/60];
    } else if (delta < 60 * 60 * 24) { // 一天内
        resultTimeStr = [NSString stringWithFormat:@"%.f小时前", delta/60/60];
    }else if (delta < 60 * 60 * 24 * 2) { // 两天内
        resultTimeStr = [NSString stringWithFormat:@"昨天"];
    } else { // 几天前
        fmt.dateFormat = @"MM月dd日";
        resultTimeStr = [fmt stringFromDate:send];
    }
    return resultTimeStr;

}

// 将十六进制的字符串转换成NSString
+ (NSString *)convertHexStrToString:(NSString *)str {
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    NSString *string = [[NSString alloc]initWithData:hexData encoding:NSUTF8StringEncoding];
    return string;
}

// 将NSString转换成十六进制的字符串
+ (NSString *)convertStringToHexStr:(NSString *)str {
    if (!str || [str length] == 0) {
        return @"";
    }
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    
    return string;
}

+ (NSAttributedString *)getAttributedString:(NSString *)string withcolor:(UIColor *)color withFont:(UIFont *)font {
    
    if (string.length == 0) {
        return [NSAttributedString new];
    }
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:string];
    [text setAttributes:@{NSFontAttributeName:font} range:NSMakeRange(0, string.length)];
    [text addAttribute:NSForegroundColorAttributeName
                 value:color
                 range:NSMakeRange(0, string.length)];
    return text;
}

+ (NSString *)getNowDataWithLongString{
    
    UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
    NSString *timeStr = [NSString stringWithFormat:@"%lld",recordTime];
    return timeStr;
}

+ (NSString *)dealNum:(NSNumber *)num {
    CGFloat floatValue = 0;
    NSString *unitStr = @"M";
    if (num.integerValue == 0) {
        return @"0M";
    }
    if (num.integerValue < 1000 && num.integerValue > 0) {
        floatValue = num.floatValue;
        unitStr = @"B";
    }else if (num.integerValue < 1000000) {
        floatValue = num.floatValue/1000;
        unitStr = @"KB";
    }else {
        floatValue = num.floatValue/1000000;
        unitStr = @"MB";
    }
    return [NSString stringWithFormat:@"%.1f %@", floatValue, unitStr];
}

+ (NSString *)dealCGFloat:(CGFloat)floatValue {
    NSString *resultStr = @"";
    if (fmodf(floatValue, 1) == 0) {
        resultStr = [NSString stringWithFormat:@"%.f",floatValue];
    }else if (fmodf(floatValue*10, 1) == 0) {
        resultStr = [NSString stringWithFormat:@"%.1f",floatValue];
    }else {
        resultStr = [NSString stringWithFormat:@"%.2f",floatValue];
    }
    return resultStr;
}

+ (NSString *)judgeFileType:(NSString *)typeStr {
    NSString *resultType = @"";
    if ([typeStr isEqualToString:@"jpg"] || [typeStr isEqualToString:@"jpeg"] || [typeStr isEqualToString:@"png"] || [typeStr isEqualToString:@"doc"] || [typeStr isEqualToString:@"docx"] || [typeStr isEqualToString:@"ppt"] || [typeStr isEqualToString:@"pptx"] || [typeStr isEqualToString:@"pdf"] || [typeStr isEqualToString:@"xls"] || [typeStr isEqualToString:@"xlsx"]) {
        resultType = @"文档";
    }else if ([typeStr isEqualToString:@"mp4"] || [typeStr isEqualToString:@"avi"] || [typeStr isEqualToString:@"rmvb"] || [typeStr isEqualToString:@"wmv"] || [typeStr isEqualToString:@"asf"] || [typeStr isEqualToString:@"mov"] || [typeStr isEqualToString:@"rm"]) {
        resultType = @"视频";
    }else {
        resultType = @"其他";
    }
    return resultType;
}

#pragma mark - 获取html文本里面的图片URL
+ (NSArray *)filterImage:(NSString *)html {
    
    if (html.length == 0) {
        return [NSArray new];
    }
    
    NSMutableArray *resultArray = [NSMutableArray array];
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<(img|IMG)(.*?)(/>|></img>|>)" options:NSRegularExpressionAllowCommentsAndWhitespace error:nil];
    NSArray *result = [regex matchesInString:html options:NSMatchingReportCompletion range:NSMakeRange(0, html.length)];
    
    for (NSTextCheckingResult *item in result) {
        NSString *imgHtml = [html substringWithRange:[item rangeAtIndex:0]];
        
        NSArray *tmpArray = nil;
        if ([imgHtml rangeOfString:@"src=\""].location != NSNotFound) {
            tmpArray = [imgHtml componentsSeparatedByString:@"src=\""];
        } else if ([imgHtml rangeOfString:@"src="].location != NSNotFound) {
            tmpArray = [imgHtml componentsSeparatedByString:@"src="];
        }
        
        if (tmpArray.count >= 2) {
            NSString *src = tmpArray[1];
            NSUInteger loc = [src rangeOfString:@"\""].location;
            if (loc != NSNotFound) {
                src = [src substringToIndex:loc];
                [resultArray addObject:src];
            }
        }
    }
    return resultArray;
}

+ (NSString *)replaceSup:(NSString *)content {
    
    NSString *newContent = content;
    newContent = [newContent stringByReplacingOccurrencesOfString:@"<sup>2</sup>" withString:@"²"];
    newContent = [newContent stringByReplacingOccurrencesOfString:@"<sup>3</sup>" withString:@"³"];
    newContent = [newContent stringByReplacingOccurrencesOfString:@"<sup>4</sup>" withString:@"⁴"];
    newContent = [newContent stringByReplacingOccurrencesOfString:@"<sup>5</sup>" withString:@"⁵"];
    newContent = [newContent stringByReplacingOccurrencesOfString:@"<sup>6</sup>" withString:@"⁶"];
    newContent = [newContent stringByReplacingOccurrencesOfString:@"<sup>7</sup>" withString:@"⁷"];
    newContent = [newContent stringByReplacingOccurrencesOfString:@"<sup>8</sup>" withString:@"⁸"];
    newContent = [newContent stringByReplacingOccurrencesOfString:@"<sup>9</sup>" withString:@"⁹"];
    return newContent;
}

#pragma mark - 保存图片至沙盒
+ (NSString *)writeImageToFile:(UIImage *)image imageName:(NSString *)imageName{
    
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
            data = UIImagePNGRepresentation(image);
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
    NSString *imageString = imgUrl.absoluteString;
    return imageString;
}

+ (NSString *)filterHTML:(NSString *)html {
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return html;
}

//方式一 后台给的格式为yyyy-MM-dd HH:mm:ss
+ (NSString *)compareCurrentTime:(NSString *)str {
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    NSDate *currentDate = [NSDate date];
    //得到两个时间差
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:timeDate];
    long temp = 0;
    NSString *result;
    if (timeInterval/60 < 1){
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    } else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    return  result;
}

//方式二 后台给的格式为 纯数字1352170595000(13位)
- (NSString *)updateTimeForRow:(NSString *)str {
    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    // 创建歌曲时间戳(后台返回的时间 一般是13位数字)
    NSTimeInterval createTime =[str floatValue]/1000;
    // 时间差
    NSTimeInterval time = currentTime - createTime;
    
    //秒转分钟
    NSInteger small = time / 60;
    if (small == 0) {
        return [NSString stringWithFormat:@"刚刚"];
    }
    if (small < 60) {
        return [NSString stringWithFormat:@"%ld分钟前",small];
    }
    // 秒转小时
    NSInteger hours = time/3600;
    if (hours<24) {
        return [NSString stringWithFormat:@"%ld小时前",hours];
    }
    //秒转天数
    NSInteger days = time/3600/24;
    if (days < 30) {
        return [NSString stringWithFormat:@"%ld天前",days];
    }
    //秒转月
    NSInteger months = time/3600/24/30;
    if (months < 12) {
        return [NSString stringWithFormat:@"%ld月前",months];
    }
    //秒转年
    NSInteger years = time/3600/24/30/12;
    return [NSString stringWithFormat:@"%ld年前",years];
}

// ISO8601的Date转String
+ (NSString *)timeStamp: (NSDate *)date {
    // 获取当前时间
//    NSDate *date = [NSDate new];
    NSDateFormatter *timeFormatter = [NSDateFormatter new];
    [timeFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [timeFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    NSString *timestamp = [timeFormatter stringFromDate:date];
    return timestamp;
}

// String转Date
+ (NSDate *)dateFromString: (NSString *)str {
    NSDateFormatter *timeFormatter = [NSDateFormatter new];
    [timeFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [timeFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    return [timeFormatter dateFromString:str];
}

// ISO8601格式字符串转Date
+ (NSDate *)dateFromISO8601String:(NSString *)string {
    
    if (!string) return nil;
    struct tm tm;
    time_t t;
    strptime([string cStringUsingEncoding:NSUTF8StringEncoding], "%Y-%m-%dT%H:%M:%S%z", &tm);
    tm.tm_isdst = -1;
    t = mktime(&tm);
    //    return [NSDate dateWithTimeIntervalSince1970:t]; // 零时区
    
    return [NSDate dateWithTimeIntervalSince1970:t + [[NSTimeZone localTimeZone] secondsFromGMT]];//东八区
}
//根据获取到的时间判断时间间隔 如 “刚刚”，“一分钟前”，“一小时前”等；
//获取时间 是用上面的方法获取的
+(NSString *)JudgmentTimeIntervalWithISOTime:(NSString *)timeStr{
    
    NSDate *theDate = [self dateFromISO8601String:timeStr];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * timeString = nil;

    NSTimeInterval cha =  0 - [theDate timeIntervalSinceDate:[NSDate date]];
    if (cha/3600 < 1) {
        timeString = [NSString stringWithFormat:@"%f", cha/60];
        timeString = [timeString substringToIndex:timeString.length-7];
        int num= [timeString intValue];
        if (num <= 1) {
            timeString = [NSString stringWithFormat:@"刚刚"];
        }else{
            timeString = [NSString stringWithFormat:@"%@分钟前", timeString];
        }
    }
    if (cha/3600 > 1 && cha/86400 < 1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString = [NSString stringWithFormat:@"%@小时前", timeString];
    }
    if (cha/86400 > 1){
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        int num = [timeString intValue];
        if (num < 2) {
            timeString = [NSString stringWithFormat:@"昨天"];
        } else{
            timeString =[dateFormatter stringFromDate:theDate];
        }
    }
    return timeString;
}

- (id)toArrayOrNSDictionary{
    if (![self isKindOfClass:[NSString class]]) {
        NSParameterAssert(@"self is not NSString!");
    }
    NSData *jsonData=[self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }
    return nil;
}
@end

//
//  InterfaceMacro.h
//  Ssdfz
//
//  Created by 王楠 on 16/1/19.
//  Copyright © 2016年 Combanc. All rights reserved.
//  接口宏

#ifndef InterfaceMacro_h
#define InterfaceMacro_h

#define isNilOrNull(obj) (obj == nil || [obj isEqual:[NSNull null]])

#define setObjectForKey(object) \
do { \
[dictionary setObject:object forKey:@#object]; \
} while (0)

#define setOptionalObjectForKey(object) \
do { \
isNilOrNull(object) ?: [dictionary setObject:object forKey:@#object]; \
} while (0)


// BaseURL
#define KBASE_URL (@"baseUrl")//(@"http://192.168.130.84:8888")

//#define BASE_URL (KUSERDEFAULT_OBJ4KEY(KBASE_URL))

#define BASE_URL (@"https://cnodejs.org/api/v1")

// 当前时间戳
#define timeSt ([NSString getNowDataWithLongString])
// 版本号  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define VERSION ([NSString stringWithFormat:@"v%@", @"2.0"])
// APPKEY
#define APPKEY (@"combanc_weike_phone_key")
// MD5加密核对
#define VERIFY ([NSString md5String:[NSString stringWithFormat:@"%@%@%@", timeSt, APPKEY, VERSION]])


#pragma mark -  1.Topic

#pragma mark -  1. 主题首页 --->GET
#define HOME_TOPICS_URL ([NSString stringWithFormat:@"%@/topics", BASE_URL])
// 参数构造
NS_INLINE NSDictionary *HomeTopicParameter(NSInteger page, NSString *tab, NSInteger limit, BOOL mdrender) {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    setObjectForKey(@(page));
    setObjectForKey(tab);
    setObjectForKey(@(limit));
    setObjectForKey(@(mdrender));
    return dictionary.copy;
}

#pragma mark - 2.主题详情

#pragma mark - 2.1 获取全部微课程科目 --->POST
#define WEIKE_SUBJECTLIST_URL ([NSString stringWithFormat:@"%@/WeikePhoneWebService/api/service/getListSubject", BASE_URL])
// 参数构造
NS_INLINE NSDictionary *WeikeSubjectList(NSString *userName, NSString *time, NSString *appKey, NSString *version, NSString *verify) {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    setObjectForKey(userName);
    setObjectForKey(time);
    setObjectForKey(appKey);
    setObjectForKey(version);
    setObjectForKey(verify);
    return dictionary.copy;
}

#pragma mark - 3.新建主题
#define ADD_TOPIC_URL ([NSString stringWithFormat:@"%@/topics", BASE_URL])

NS_INLINE NSDictionary *AddTopicParameter(NSString *title, NSString *content, NSString *accesstoken, NSString *tab) {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    setObjectForKey(title);
    setObjectForKey(content);
    setObjectForKey(accesstoken);
    setObjectForKey(tab);
    return dictionary.copy;
}

#pragma mark - 4.评论点赞
#define COMMENT_LIKE_URL ([NSString stringWithFormat:@"%@/reply/", BASE_URL])

NS_INLINE NSDictionary *CommentLikeParameter(NSString *accesstoken) {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    setObjectForKey(accesstoken);
    return dictionary.copy;
}

#pragma mark - 5.新建评论
#define CREATE_COMMENT_URL ([NSString stringWithFormat:@"%@/topic/", BASE_URL])

NS_INLINE NSDictionary *CreateCommentParameter(NSString *accesstoken, NSString *content, NSString *reply_id) {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    setObjectForKey(accesstoken);
    setObjectForKey(content);
    setObjectForKey(reply_id);
    return dictionary.copy;
}

#pragma mark - 5.收藏话题
#define COLLECT_TOPIC_URL ([NSString stringWithFormat:@"%@/topic_collect/collect", BASE_URL])

NS_INLINE NSDictionary *CollectTopicParameter(NSString *accesstoken, NSString *topic_id) {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    setObjectForKey(accesstoken);
    setObjectForKey(topic_id);
    return dictionary.copy;
}

#pragma mark - 6.取消收藏话题
#define DELCOLLECT_TOPIC_URL ([NSString stringWithFormat:@"%@/topic_collect/de_collect", BASE_URL])

NS_INLINE NSDictionary *DelCollectTopicParameter(NSString *accesstoken, NSString *topic_id) {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    setObjectForKey(accesstoken);
    setObjectForKey(topic_id);
    return dictionary.copy;
}

#pragma mark - 7.用户详情
#define USER_DETAIL_URL ([NSString stringWithFormat:@"%@/user/Pengsisi", BASE_URL])


#endif /* InterfaceMacro_h */

//
//  ReplyTableViewCell.h
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/6.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LikeBlock)(NSIndexPath *indexPath);

@interface ReplyTableViewCell : UITableViewCell

- (void)configureCellAvaterUrl: (NSString *)url nickName: (NSString *)name date: (NSString *)dateStr likeCount: (NSString *)count content: (NSString *)content is_uped: (BOOL)is_uped;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) LikeBlock block;

@end

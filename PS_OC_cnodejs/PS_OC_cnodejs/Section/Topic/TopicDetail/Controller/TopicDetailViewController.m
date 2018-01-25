//
//  TopicDetailViewController.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/6.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "TopicDetailViewController.h"
#import "TopicDetailModel.h"
#import "ReplyTableViewCell.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "UIBarButtonItem+Base.h"

@interface TopicDetailViewController () <UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate, UITextFieldDelegate>

@property ( nonatomic,strong ) UITableView *tableView;
@property ( nonatomic,strong ) UIWebView *webView;
@property (nonatomic, strong) TopicDetailModel *detailModel;
@property (nonatomic, copy) NSString *commentStr;
@property (nonatomic, strong) UIButton *btn ;

@end

@implementation TopicDetailViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"话题";
    [self loadTopicDetailData];
    [self setNavItem];
}

#pragma mark - 数据请求

- (void)loadTopicDetailData {
    NSString *url = [NSString stringWithFormat:@"https://cnodejs.org/api/v1/topic/%@", self.topticId];
    [HTTPTool getWithURL:url headers:nil params:nil success:^(id json) {
        if (json[@"success"]) {
            NSLog(@"json---%@", json);
            self.detailModel = [TopicDetailModel mj_objectWithKeyValues:json[@"data"]];
            [self.webView loadHTMLString:self.detailModel.content baseURL:nil];
             [self setupUI];
            [self createBottomView];
//            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"error -- %@", error);
    }];
}

// 点赞
- (void)replyLikeRequest: (NSString *)commentId {
    NSDictionary *params = CommentLikeParameter(AccessToken);
    // 字典转data
    NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    NSString *url = [NSString stringWithFormat:@"%@%@/ups", COMMENT_LIKE_URL, commentId];
    [HTTPTool postWithUrl:url body:data success:^(id json) {
        NSLog(@"--json--%@", json);
        if (json[@"success"]) {
            NSLog(@"点赞成功");
            // 点赞成功需要再次请求列表数据
            [self loadTopicDetailData];
        }
    } failure:^(id json) {
        NSLog(@"error -- %@", json);
    }];
}

// 新建评论
- (void)createCommentWithContent: (NSString *)content topicId: (NSString *)replyId {
    NSDictionary *params = CreateCommentParameter(AccessToken, content, replyId);
    // 字典转data
    NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    NSString *topicId = self.detailModel.ID;
    NSString *url = [NSString stringWithFormat:@"%@%@/replies", CREATE_COMMENT_URL, topicId];
    [HTTPTool postWithUrl:url body:data success:^(id json) {
        NSLog(@"--json--%@", json);
        if (json[@"success"]) {
            NSLog(@"评论成功");
            
        }
    } failure:^(id json) {
        NSLog(@"error -- %@", json);
    }];
}

// 收藏主题/取消收藏主题 isCollect: 收藏
- (void)collectRequest: (BOOL)isCollect {
    NSDictionary *params = CollectTopicParameter(AccessToken, self.detailModel.ID);
    // 字典转data
    NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
    NSString *url;
    if (isCollect) {
        url = COLLECT_TOPIC_URL;
    } else {
        url = DELCOLLECT_TOPIC_URL;
    }
    [HTTPTool postWithUrl:url body:data success:^(id json) {
        NSLog(@"--json--%@", json);
        if (json[@"success"]) {
            NSLog(@"收藏成功");
            self.btn.selected = !self.btn.selected;
        }
    } failure:^(id json) {
        NSLog(@"error -- %@", json);
    }];
}

- (void)setupUI {
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.webView;
}

- (void)setNavItem {
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn.frame = CGRectMake(0, 0, 30, 30);
    [self.btn setImage:[UIImage imageNamed:@"task_question_result_analysis_halfright_icon"] forState:UIControlStateNormal];
    [self.btn setImage:[UIImage imageNamed:@"task_question_result_analysis_right_icon"] forState:UIControlStateSelected];
    [self.btn addTarget:self action:@selector(collectAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.btn];
}

- (void)createBottomView {
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, K_SCREEN_HEIGHT - 44, K_SCREEN_WIDTH, 44)];
    bottomView.backgroundColor = RGBA(248, 248, 248, 1);
    [self.view addSubview:bottomView];
    UITextField *commentTF = [[UITextField alloc]initWithFrame:bottomView.bounds];
    commentTF.placeholder = @"  发表评论";
    commentTF.delegate = self;
    UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    publishBtn.frame = CGRectMake(0, 0, 30, 30);
    [publishBtn setImage:[UIImage imageNamed:@"send"] forState:UIControlStateNormal];
    [publishBtn addTarget:self action:@selector(sendCommentAction:) forControlEvents:UIControlEventTouchUpInside];
    commentTF.rightView = publishBtn;
    commentTF.rightViewMode = UITextFieldViewModeAlways;//一定要加上这句代码
    [bottomView addSubview:commentTF];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView{
    
}

//正则表达式，自适应webView适应屏幕，图片文字自适应屏幕
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSString *js = @"function imgAutoFit() { \
    var imgs = document.getElementsByTagName('img'); \
    for (var i = 0; i < imgs.length; ++i) {\
    var img = imgs[i];   \
    img.style.maxWidth = %f;   \
    } \
    }";
    js = [NSString stringWithFormat:js, [UIScreen mainScreen].bounds.size.width - 20];
    
    [webView stringByEvaluatingJavaScriptFromString:js];
    [webView stringByEvaluatingJavaScriptFromString:@"imgAutoFit()"];
    
    //获取到webview的高度
    CGFloat height = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    self.webView.frame = CGRectMake(self.webView.frame.origin.x,self.webView.frame.origin.y, self.view.frame.size.width, height);
    self.tableView.tableHeaderView = self.webView;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.detailModel.replies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ReplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReplyTableViewCell" forIndexPath:indexPath];
    [self configureReplyCell:cell indexPath:indexPath];
    cell.block = ^(NSIndexPath *indexPath) {
        // 点赞
        ReplyModel *model = self.detailModel.replies[indexPath.row];
        [self replyLikeRequest:model.ID];
    };
    return cell;
}

- (void)configureReplyCell: (ReplyTableViewCell*) cell indexPath: (NSIndexPath *)indexPath {
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ReplyModel *model = self.detailModel.replies[indexPath.row];
    cell.indexPath = indexPath;
    [cell configureCellAvaterUrl:model.author.avatar_url nickName:model.author.loginname date:model.create_at likeCount: [NSString stringWithFormat:@"%ld", model.ups.count] content:model.content is_uped: model.is_uped];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, 20)];
    label.backgroundColor = [UIColor whiteColor];
    label.text = [NSString stringWithFormat:@"   %ld 回复", self.detailModel.replies.count];
    label.font = FONT_17;
    label.layer.borderColor = [UIColor lightGrayColor].CGColor;
    label.layer.borderWidth = 0.5;
    [self setRichNumberWithLabel:label Color:[UIColor greenColor] FontSize:17];
    return label;
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    self.commentStr = textField.text;
    return YES;
}

#pragma mark - 懒加载

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT - 44) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 100;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        // 注册cell
        [_tableView registerNib:[UINib nibWithNibName:@"ReplyTableViewCell" bundle:nil] forCellReuseIdentifier:@"ReplyTableViewCell"];
    }
    return _tableView;
}

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, 100)];
        _webView.scrollView.bounces = NO;
        _webView.scrollView.bouncesZoom = NO;
        _webView.delegate = self;
    }
    return _webView;
}

// 給数字设置富文本
- (void)setRichNumberWithLabel:(UILabel *)label Color:(UIColor *) color FontSize:(CGFloat)size{
    //将Label的text转化为NSMutalbeAttributedString
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:label.text];
    //定义空字符串
    NSString *temp = nil;
    //根据属属性字符串的长度循环
    for(int i = 0; i < [attributedString length]; i++){
        //每次取1个长度的字符串
        temp = [label.text substringWithRange:NSMakeRange(i, 1)];
        //判读这个长度的字符串中是否包含数字以及标点符号
        if([temp isEqualToString:@"0"] || [temp isEqualToString:@"1"] || [temp isEqualToString:@"2"] || [temp isEqualToString:@"3"] || [temp isEqualToString:@"4"] || [temp isEqualToString:@"5"] || [temp isEqualToString:@"6"] || [temp isEqualToString:@"7"] || [temp isEqualToString:@"8"] || [temp isEqualToString:@"9"]|| [temp isEqualToString:@"."] || [temp isEqualToString:@"-"]){
            //给符合条件的属性字符串添加颜色,字体
            [attributedString setAttributes:@{NSForegroundColorAttributeName: color, NSFontAttributeName: [UIFont systemFontOfSize:size]} range:NSMakeRange(i, 1)];
        }
    }
    //重新给Label的text传递处理好的属性字符串
    label.attributedText = attributedString;
}

// 收藏
- (void)collectAction: (UIBarButtonItem *)item {
    self.btn.selected = !self.btn.selected;
    if (!self.btn.selected) {
        NSLog(@"取消收藏");
        [self collectRequest:NO];
    } else {
        [self collectRequest:YES];
        NSLog(@"收藏");
    }
}

// 发表评论
- (void)sendCommentAction: (UIButton *)button {
    // 发送请求
    [self createCommentWithContent:self.commentStr topicId:@""];
    [self loadTopicDetailData];
}

@end


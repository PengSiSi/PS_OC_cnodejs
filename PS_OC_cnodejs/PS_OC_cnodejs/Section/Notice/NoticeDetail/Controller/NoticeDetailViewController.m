//
//  NoticeDetailViewController.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/6.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "NoticeDetailViewController.h"

@interface NoticeDetailViewController () <UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate>

@property ( nonatomic,strong ) UITableView *tableView;
@property ( nonatomic,strong ) UIWebView *webView;

@end

@implementation NoticeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"话题";
    [self loadTopicDetailData];
    [self setupUI];
}

- (void)loadTopicDetailData {
    NSString *url = @"https://cnodejs.org/api/v1/topic/5a2403226190c8912ebaceeb";
    [HTTPTool getWithURL:url headers:nil params:nil success:^(id json) {
        if (json[@"success"]) {
            NSLog(@"--json--%@", json);
        }
    } failure:^(NSError *error) {
        NSLog(@"error---%@",error);
    }];
}


- (void)setupUI {
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.webView;
    [self.webView loadHTMLString:@"" baseURL:nil];
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    [self configureCommomCell:cell indexPath:indexPath];
    cell.textLabel.text = @"思思回复";
    return cell;
}

//- (void)configureCommomCell: (CommonTableViewCell*) cell indexPath: (NSIndexPath *)indexPath {
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

#pragma mark - 懒加载

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 100;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        // 注册cell
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
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

@end

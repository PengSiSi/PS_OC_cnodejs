//
//  TopicListViewController.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/5.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "TopicListViewController.h"
#import "TopicListTableViewCell.h"
#import "HomeTopicModel.h"
#import "TopicDetailViewController.h"
#import "CustomGifHeader.h"
#import "CustomGifFooter.h"
#import "LoadingView.h"

static NSString *const identify = @"TopicListTableViewCell";

@interface TopicListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger page;

@end

@implementation TopicListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    [self initialData];
    [self requestData];
    [self createMJRefresh];
}

// 初始化数据
- (void)initialData {
    self.page = 0;
}

// 数据请求
- (void)requestData {
    // Loading
    [LoadingView showLoadingInView:self.view];
    NSDictionary *param = HomeTopicParameter(self.page, self.tabStr, 1, false);
    [HTTPTool getWithURL:HOME_TOPICS_URL headers:param params:nil success:^(id json) {
        NSLog(@"---json---%@", json);
        if (json[@"success"]) {
            [LoadingView hideLoadingForView:self.view];
            if (self.dataArray.count > 0) {
                [self.dataArray addObjectsFromArray:[HomeTopicModel mj_objectArrayWithKeyValuesArray:json[@"data"]]];
            } else {
                self.dataArray = [HomeTopicModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
            }
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        NSLog(@"---error---%@",error);
    }];
}

// 刷新
- (void)createMJRefresh {
    self.tableView.mj_header = [CustomGifHeader headerWithRefreshingBlock:^{
        self.page = 0;
        [self requestData];
    }];
    self.tableView.mj_footer = [CustomGifFooter footerWithRefreshingBlock:^{
        self.page ++;
        [self requestData];
    }];
}

#pragma mark - 设置界面

- (void)setUI {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT - 64 - 74) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [[UIView alloc]init];
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"TopicListTableViewCell" bundle:nil] forCellReuseIdentifier:identify];
    [self.view addSubview: self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TopicListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    [self configureTopicListCell:cell indexPath:indexPath];
    return cell;
}

- (void)configureTopicListCell: (TopicListTableViewCell*) cell indexPath: (NSIndexPath *)indexPath {
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    HomeTopicModel *model = self.dataArray[indexPath.row];
    cell.model = model;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return FLT_EPSILON;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return FLT_EPSILON;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 99;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TopicDetailViewController *detailVc = [[TopicDetailViewController alloc]init];
    HomeTopicModel *model = self.dataArray[indexPath.row];
    detailVc.topticId = model.topicID;
    [self.navigationController pushViewController:detailVc animated:YES];
}

/** 接收到系统的内存警告时 */
- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
    /**
     *  YYWebImage/SDWebImage 清除缓存
     */
//    [[YYImageCache sharedCache].memoryCache removeAllObjects];
    [[SDImageCache sharedImageCache]cleanDisk];
    [[SDImageCache sharedImageCache]clearMemory];
    
    /**
     *  UIWebView 清除缓存
     */
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    /**
     *  SDWebImage 清除缓存
     */
    [[SDImageCache sharedImageCache] clearMemory];
    
}

@end

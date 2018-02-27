//
//  RefreshDemoViewController.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2018/1/24.
//  Copyright © 2018年 思 彭. All rights reserved.
//

#import "RefreshDemoViewController.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
static CGFloat HeaderViewHegiht = 150.0;

@interface RefreshDemoViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *headerView;
// 刷新控件
@property (nonatomic, strong) RefreshView *refreshView;

@end

@implementation RefreshDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;
    // 0.1 创建TableView
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = 50;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    // 0.2 向下偏移150
    self.tableView.contentInset = UIEdgeInsetsMake(HeaderViewHegiht, 0, 0, 0);
    
    // 0.3 添加顶部视图
    self.headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -HeaderViewHegiht, kWidth, HeaderViewHegiht)];
//    self.headerView.image = [UIImage imageNamed:@"huanghun.jpg"];
    self.headerView.backgroundColor = [UIColor grayColor];
    self.headerView.contentMode = UIViewContentModeScaleAspectFill;
    [self.tableView addSubview:self.headerView];
    
    // 创建刷新
    [self creatRefreshView];
}

- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
    [self setNeedsStatusBarAppearanceUpdate];
    [self setStatusBarBackgroundColor:[UIColor redColor]];
    // 状态栏样式
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

// 隐藏状态栏
//- (BOOL)prefersStatusBarHidden {
//    return YES;
//}

//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}


// 刷新控件
- (void)creatRefreshView {
    self.refreshView = [[RefreshView alloc] initWithFrame:CGRectMake((kWidth - 30) /2, 40, 30, 30)];
    [self.view insertSubview:self.refreshView aboveSubview:self.tableView];
    self.refreshView.refreshStyle = RefreshViewStyleLoad;
    self.refreshView.refreshOffset = 130.0;
    
    __weak typeof(self)weakSelf = self;
    [self.refreshView startAnimation:^{
        [weakSelf handleData];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    // 上拉越来越大，下拉越来越小
    NSLog(@"contentOffsetY = %f", scrollView.contentOffset.y);
    
    //1 头部背景图拉伸形变    上拉
    if (scrollView.contentOffset.y < - HeaderViewHegiht) {
        CGRect newHeaderFrame = self.headerView.frame;
        newHeaderFrame.origin.y = scrollView.contentOffset.y;
        newHeaderFrame.size.height = - scrollView.contentOffset.y;
        self.headerView.frame = newHeaderFrame;
    }
    
    //2 刷新控件设置
    __weak typeof(self)weakSelf = self;
    
    CGFloat refreshOffsetY = -scrollView.contentOffset.y - HeaderViewHegiht;
    
    [self.refreshView contentOffsetY:refreshOffsetY withDragging:scrollView.isDragging isStyleLoad:^{
        [weakSelf handleData];
    }];
}

- (void)handleData{
    // 模拟数据请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.refreshView removeAnimation];
        
    });
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    return cell;
}

@end

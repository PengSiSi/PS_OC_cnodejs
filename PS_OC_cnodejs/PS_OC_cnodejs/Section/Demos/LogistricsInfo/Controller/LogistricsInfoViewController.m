//
//  LogistricsInfoViewController.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2018/1/2.
//  Copyright © 2018年 思 彭. All rights reserved.
//

#import "LogistricsInfoViewController.h"
#import "LogistricsInfoTableViewCell.h"
#import <UITableView+FDTemplateLayoutCell.h>

@interface LogistricsInfoViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation LogistricsInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"物流信息Demo";
    [self setUI];
}

#pragma mark - 设置界面

- (void)setUI {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    // 注册cell
    [self.tableView registerClass:[LogistricsInfoTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview: self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LogistricsInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    // 获取1-10之间的整数
    int value = (arc4random() % 20) + 1;
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i < value; i++) {
        [arr addObject:@"1"];
    }
    [self configureCell:cell indexPath:indexPath dataArray:[arr copy]];
    return cell;
}

- (void)configureCell: (LogistricsInfoTableViewCell *)cell indexPath:(NSIndexPath *)indexPath dataArray: (NSArray *)dataArray {
    cell.dataArray = dataArray;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return FLT_EPSILON;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    __weak typeof(self) weakSelf = self;
//    return [tableView fd_heightForCellWithIdentifier:@"cell" configuration:^(LogistricsInfoTableViewCell *cell) {
//        // 获取1-10之间的整数
//        int value = (arc4random() % 10) + 1;
//        NSMutableArray *arr = [NSMutableArray array];
//        for (NSInteger i = 0; i < 5; i++) {
//            [arr addObject:@"1"];
//        }
//        [weakSelf configureCell:cell indexPath:indexPath dataArray:[arr copy]];
//    }];
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

@end

//
//  SettingViewController.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/20.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "SettingViewController.h"
#import "CollectionLayOutVC.h"
#import "LogistricsInfoViewController.h"
#import "ExpandViewController.h"
#import "NumberTFViewController.h"
#import "RefreshDemoViewController.h"
#import "LKDBHelperViewController.h"
#import "ColorGradientDemoViewController.h"
#import "ScrollViewDemoViewController.h"

@interface SettingViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    self.dataArray = @[@"瀑布流Demo", @"物流信息Demo", @"回复框实现", @"数字键盘添加完成", @"自定义刷新控件", @"LKDB数据库操作使用", @"UITableView颜色渐变", @"滑动切换"];
    [self setUI];
}

#pragma mark - 设置界面

- (void)setUI {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [[UIView alloc]init];
    // 注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[CollectionLayOutVC new] animated:YES];
    } else if (indexPath.row == 1) {
        [self.navigationController pushViewController:[LogistricsInfoViewController new] animated:YES];
    } else if (indexPath.row == 2) {
        [self.navigationController pushViewController:[ExpandViewController new] animated:YES];
    } else if (indexPath.row == 3) {
        [self.navigationController pushViewController:[NumberTFViewController new] animated:YES];
    } else if (indexPath.row == 4) {
        [self.navigationController pushViewController:[RefreshDemoViewController new] animated:YES];
    } else if (indexPath.row == 5) {
        [self.navigationController pushViewController:[LKDBHelperViewController new] animated:YES];
    } else if (indexPath.row == 6) {
        [self.navigationController pushViewController:[ColorGradientDemoViewController new] animated:YES];
    } else if (indexPath.row == 7) {
        [self.navigationController pushViewController:[ScrollViewDemoViewController new] animated:YES];
    }
}

@end

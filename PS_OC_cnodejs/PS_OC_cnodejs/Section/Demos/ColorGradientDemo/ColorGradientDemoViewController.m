//
//  ColorGradientDemoViewController.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2018/2/27.
//  Copyright © 2018年 思 彭. All rights reserved.
//

#import "ColorGradientDemoViewController.h"
#import "ColorGradientCell.h"

@interface ColorGradientDemoViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ColorGradientDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UITableView颜色渐变";
    [self setUI];
}

#pragma mark - 设置界面

- (void)setUI {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.tableHeaderView = [[UIView alloc]init];
    self.tableView.rowHeight = 62;
    // 显示左边的白色底线
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 50, 0, 0);
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"ColorGradientCell" bundle:nil] forCellReuseIdentifier:@"ColorGradientCell"];
    [self.view addSubview: self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ColorGradientCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ColorGradientCell" forIndexPath:indexPath];
    cell.titileLabel.font = [UIFont systemFontOfSize:15];
    cell.titileLabel.text = @"思思";
    cell.tipLabel.text = [NSString stringWithFormat:@"%ld", indexPath.section + 1];
    // 透明度来实现渐变
    cell.tipLabel.alpha = (tableView.numberOfSections - indexPath.section) * 0.2;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0001f;
}


@end

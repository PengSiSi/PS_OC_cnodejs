//
//  NoticeViewController.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/11/28.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "NoticeViewController.h"
#import "CommonTableViewCell.h"
#import "NoticeDetailViewController.h"
#import "UITabBar+Badge.h"

static NSString *const CommonTableViewCellIdentify = @"CommonTableViewCell";

@interface NoticeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *iconImgArray;
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialData];
    [self setUI];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 点击隐藏小红点
    [self.tabBarController.tabBar hideBadgeOnItemIndex:2];
}

- (void)initialData {
    self.iconImgArray = @[@"notice", @"comment"];
    self.titleArray = @[@"系统消息", @"已读消息"];
}

#pragma mark - 设置界面

- (void)setUI {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [[UIView alloc]init];
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"CommonTableViewCell" bundle:nil] forCellReuseIdentifier:CommonTableViewCellIdentify];
    [self.view addSubview: self.tableView];
    UILabel *noMessageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, 20)];
    noMessageLabel.text = @"暂无消息";
    noMessageLabel.textColor = [UIColor lightGrayColor];
    noMessageLabel.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableFooterView = noMessageLabel;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.iconImgArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CommonTableViewCellIdentify forIndexPath:indexPath];
    [self configureCommomCell:cell indexPath:indexPath];
    return cell;
}

- (void)configureCommomCell: (CommonTableViewCell*) cell indexPath: (NSIndexPath *)indexPath {
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell configureCellWithImage:self.iconImgArray[indexPath.row] title:self.titleArray[indexPath.row]];
}

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

@end

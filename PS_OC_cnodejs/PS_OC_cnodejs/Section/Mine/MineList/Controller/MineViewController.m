//
//  MineViewController.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/11/28.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "MineViewController.h"
#import "CommonTableViewCell.h"
#import "NoLoginHeaderView.h"
#import "LoginHeadrView.h"
#import "LoginViewController.h"
#import "MineInfoModel.h"
#import "SettingViewController.h"

static NSString *const CommonCellIdentify = @"CommonTableViewCell";

@interface MineViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *noLoginDataArray;
@property (nonatomic, strong) NSArray *noLoginImagesArray;
@property (nonatomic, strong) NSArray *loginDataArray;
@property (nonatomic, strong) NSArray *loginImagesArray;
@property (nonatomic, assign) BOOL isLoginFlag;
@property (nonatomic, strong) MineInfoModel *mineInfoModel;
@property (nonatomic, strong) LoginHeadrView *loginView;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialData];
    [self setUI];
    [self requestUserDetail];
}

// 每次都会调用
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isLoginFlag = [[[NSUserDefaults standardUserDefaults]objectForKey:isLogin] boolValue];
//    NSLog(@"isLoginFlag = %ld", self.isLoginFlag);
    // 注意这里要刷新一次，否则dismiss回来不刷新
    [self.tableView reloadData];
}

- (void)initialData {
    self.noLoginImagesArray = @[@[@"comment", @"post", @"collection"], @[@"setting"]];
    self.noLoginDataArray = @[@[@"最近回复", @"最新发布", @"话题收藏"], @[@"设置"]];
    self.loginDataArray = @[@[@"论坛积分", @"代码仓库"], @[@"最近回复", @"最新发布", @"话题收藏"], @[@"设置"]];
    self.loginImagesArray = @[@[@"integral", @"github"], @[@"comment", @"post", @"collection"], @[@"setting"]];
}

#pragma mark - 数据请求

- (void)requestUserDetail {
    [HTTPTool getWithURL:USER_DETAIL_URL headers:nil params:nil success:^(id json) {
        if (json[@"success"]) {
            self.mineInfoModel = [MineInfoModel mj_objectWithKeyValues:json[@"data"]];
            [self.tableView reloadData];
            // 更新头信息 注意：在这里居然不能更新UI
//            [self.loginView configureHeaderViewWithAvater:self.mineInfoModel.avatar_url nickName:self.mineInfoModel.loginname registerTime:self.mineInfoModel.create_at];
        }
    } failure:^(NSError *error) {
        NSLog(@"失败");
    }];
}

#pragma mark - 设置界面

- (void)setUI {
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.tableFooterView = [[UIView alloc]init];
    // 注册cell
    [self.tableView registerNib:[UINib nibWithNibName: NSStringFromClass([CommonTableViewCell class]) bundle:nil] forCellReuseIdentifier:CommonCellIdentify];
    [self.view addSubview: self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.isLoginFlag) {
        return self.loginDataArray.count;
    }
    return self.noLoginDataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.isLoginFlag) {
        NSArray *sectionArray = self.loginDataArray[section];
        return sectionArray.count;
    }
    NSArray *sectionArray = self.noLoginDataArray[section];
    return sectionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CommonCellIdentify forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray *sectionImageArray,*sectionArray,*sectionImageArray1,*sectionArray1;
    if (!self.isLoginFlag) {
        sectionImageArray = self.noLoginImagesArray[indexPath.section];
        sectionArray = self.noLoginDataArray[indexPath.section];
    } else {
        sectionImageArray1 = self.loginImagesArray[indexPath.section];
        sectionArray1 = self.loginDataArray[indexPath.section];
    }
    cell.iConImgView.image = [UIImage imageNamed:!self.isLoginFlag ? sectionImageArray[indexPath.row] : sectionImageArray1[indexPath.row]];
    cell.titleLabel.text = self.isLoginFlag ? sectionArray1[indexPath.row] : sectionArray[indexPath.row];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.subTitleLabel.text = self.mineInfoModel.score;
                break;
            case 1:
                cell.subTitleLabel.text = self.mineInfoModel.loginname;
                break;
            default:
                break;
        }
    }
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                cell.subTitleLabel.text = [NSString stringWithFormat:@"%ld",self.mineInfoModel.recent_replies.count];
                break;
            case 1:
                cell.subTitleLabel.text = [NSString stringWithFormat:@"%ld",self.mineInfoModel.recent_topics.count];
                break;
            default:
                break;
        }
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 74.0f;
    }
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        if (self.isLoginFlag) {
            self.loginView = [LoginHeadrView loginHeadrView];
            [self.loginView configureHeaderViewWithAvater:self.mineInfoModel.avatar_url nickName:self.mineInfoModel.loginname registerTime:self.mineInfoModel.create_at];
            return self.loginView;
        } else {
            NoLoginHeaderView *noLoginView = [NoLoginHeaderView noLoginHeadrView];
            __weak typeof(self) weakSelf = self;
            noLoginView.tapBlock = ^{
                // 跳转到登录页面
                LoginViewController *loginVc = [[LoginViewController alloc]init];
                [weakSelf presentViewController:loginVc animated:YES completion:nil];
            };
            return noLoginView;
        }
    }
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 0) {
        [self.navigationController pushViewController:[SettingViewController new] animated:YES];
    }
}

@end

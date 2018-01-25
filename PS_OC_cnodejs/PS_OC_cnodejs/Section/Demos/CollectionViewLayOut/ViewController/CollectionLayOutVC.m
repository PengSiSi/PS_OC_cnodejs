//
//  CollectionLayOutVC.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/20.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "CollectionLayOutVC.h"
#import "MyTableViewCell.h"
#import "SectionHeaderView.h"
#import "HotRecommendListModel.h"
#import "UIViewExt.h"

#define URL @"https://api.gacha.163.com/api/v1/discovery"
#define FIT_WIDTH   [UIScreen mainScreen].bounds.size.width/375
#define FIT_HEIGHT  [UIScreen mainScreen].bounds.size.height/667

@interface CollectionLayOutVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datArray;
@property (nonatomic, strong) HotRecommendListModel *model;
@property (nonatomic, strong) MyTableViewCell *cell;
@property (nonatomic, copy) NSString *selectFlagStr;

@end

@implementation CollectionLayOutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"瀑布流Demo";
    [self setUI];
    [self requestData];
}

#pragma mark - 数据请求
- (NSString *)getNowTimeTimestamp{
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    return [NSString stringWithFormat:@"%.0f",interval];
}

- (void)requestData {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"version"] = [self getNowTimeTimestamp];
    [HTTPTool getWithURL:URL headers:nil params:param success:^(id json) {
        NSArray *discoverInfos = json[@"result"][@"discoverInfos"];
        for (NSDictionary *dic in discoverInfos) {
            NSString *type = dic[@"itemType"];
            if ([type isEqualToString:@"recommendList"]) {
                id str = dic[@"data"];
                id childArray = [str toArrayOrNSDictionary];
                
                self.model = [HotRecommendListModel mj_objectWithKeyValues:childArray];
                [self handleData];
            }
        }
        // 主线程刷新UI
        [self mainQueueUpdateUI];
    } failure:^(NSError *error) {
        NSLog(@"error");
    }];
}

// 处理图片的真实宽高
- (void)handleData {
    for (HotRecommendModel *smallModel in self.model.data) {
        NSString *suffix = smallModel.imgId;
        if (![suffix isKindOfClass:[NSString class]]) return;
        smallModel.imageSuffix = [self componentSeparatedByString:suffix];
        if (smallModel.width && smallModel.height) {
            //实际宽度
            smallModel.realWidth = (K_SCREEN_WIDTH - 2)/1.0;
            
            //长图（392,463）、正方形图（比例接近1，296,350）、短图（294,347）
            //首先判断是否长图
            if (smallModel.height / smallModel.width > 1.5) {
                smallModel.realHeight = 463 * FIT_WIDTH;
            }else if(smallModel.height / smallModel.width < 1){
                smallModel.realHeight = 347 * FIT_WIDTH;
            }else if (smallModel.height / smallModel.width >= 1){
                smallModel.realHeight = 350 * FIT_WIDTH;
            }else{
                smallModel.realHeight = smallModel.realWidth;
            }
        }
    }
}

- (NSString *)componentSeparatedByString:(NSString *)string{
    if (![string isKindOfClass:[NSString class]]) {
        NSParameterAssert(@"ss is not NSString!");
    }
    string = [string lowercaseString];
    NSArray *result=[string componentsSeparatedByString:@"."];
    if ([result.lastObject isEqualToString:@"jpeg"]) {
        return @"jpeg";
    }else if ([result.lastObject isEqualToString:@"png"]){
        return @"png";
    }else if ([result.lastObject isEqualToString:@"webp"]){
        return @"webp";
    }
    return @"png";
}

#pragma mark - 设置界面

- (void)setUI {
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, K_SCREEN_WIDTH, K_SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [[UIView alloc]init];
    // 注册cell
    [self.tableView registerClass:[MyTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview: self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    self.cell = cell;
    if (self.model.data.count > 0) {
        [cell setDataArray:self.model.data];
    }
    __weak typeof(self) weakSelf = self;
    __weak typeof(cell) weakCell = cell;
    cell.updateCellHeight = ^(CGFloat height){
        weakCell.height = [self tableView:tableView heightForRowAtIndexPath:indexPath];
        [weakSelf mainQueueUpdateUI];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.cell.cacheHeight;
}

- (void)mainQueueUpdateUI {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    SectionHeaderView *headerView = [[NSBundle mainBundle]loadNibNamed:@"SectionHeaderView" owner:self options:nil][0];
    headerView.frame = CGRectMake(0, 0, K_SCREEN_WIDTH, 30);
    [headerView.changeLayoutButton addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    return headerView;
}

// 瀑布流切换
- (void)changeAction: (UIButton *)button {
    if ([self.selectFlagStr isEqualToString:@"0"]) {
        self.selectFlagStr = @"1";
    } else {
        self.selectFlagStr = @"0";
    }
    if ([self.selectFlagStr isEqualToString:@"0"]) {
        self.cell.style = itemStyleSingle;
        self.cell.needUpdate = YES;
        [self.tableView reloadData];
    } else{
        self.cell.style = itemStyleDouble;
        self.cell.needUpdate = YES;
        [self.tableView reloadData];
    }
}

@end

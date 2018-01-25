//
//  TopicSearchViewController.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2017/12/6.
//  Copyright © 2017年 思 彭. All rights reserved.
//

#import "TopicSearchViewController.h"
#import "HistorySearchCell.h"
#import "HotSerachCell.h"
#import "TagsView.h"
#import "SearchBar.h"

static NSString *const HotCellID = @"HotCellID";
static NSString *const HistoryCellID = @"HistoryCellID";

@interface TopicSearchViewController () <UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,TagsViewDelegate>

@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) SearchBar *searchBar;
/** 历史搜索数组 */
@property (nonatomic, strong) NSMutableArray *historyArr;
/** 热门搜索数组 */
@property (nonatomic, strong) NSMutableArray *HotArr;
/** 得到热门搜索TagView的高度 */
@property (nonatomic ,assign) CGFloat tagViewHeight;

@end

@implementation TopicSearchViewController

- (instancetype)init{
    
    if (self = [super init]) {
        self.historyArr = [NSMutableArray array];
        self.HotArr = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self createUI];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

-(void)initData{
    
    /**
     *  造热门搜索的假数据
     */
    self.historyArr = [NSMutableArray arrayWithObjects:@"Node.js",@"C#",@"HTML5",@"Web",@"Swift", nil];
    
    self.HotArr = [NSMutableArray arrayWithObjects:@"Node.js",@"web编程",@"JAVA8",@"JAVA",@"Objective-c",@"SWift",@"iOS分享之路",@"HTML5",@"iOS直播",@"APPLE", nil];
}

- (void)createUI {
    self.view.backgroundColor=[UIColor whiteColor];
    SearchBar *bar = [[SearchBar alloc] initWithFrame:CGRectMake(0, 20, K_SCREEN_WIDTH - 100, 30)];
    bar.layer.cornerRadius=15;
    bar.layer.masksToBounds=YES;
    bar.placeholder = @"输入主题";
    _searchBar = bar;
    bar.delegate = self;
    self.navigationItem.titleView = bar;
    [self.view addSubview:self.tableview];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(searchAction)];
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setTitle:@"取消" forState:UIControlStateNormal];
    [searchBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    searchBtn.frame = CGRectMake(K_SCREEN_WIDTH - 60, 20, 40, 40);
    [searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bar];
    [self.view addSubview:searchBtn];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.historyArr.count == 0) {
        return 1;
    } else {
        if (section == 0) {
            return 1;
        } else {
            return self.historyArr.count;
        }
    }
}

/** section的数量 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.historyArr.count == 0) {
        return 1;
    } else {
        return 2;
    }
}

/** 第一个cell（热门搜索的cell不可编辑） */
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return UITableViewCellEditingStyleNone;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.historyArr.count == 0) {
        HotSerachCell *hotCell = [tableView dequeueReusableCellWithIdentifier:HotCellID forIndexPath:indexPath];
        
        hotCell.selectionStyle = UITableViewCellSelectionStyleNone;
        hotCell.userInteractionEnabled = YES;
        hotCell.hotSearchArr = self.HotArr;
        hotCell.tagsView.delegate = self;
        /** 将通过数组计算出的tagV的高度存储 */
        self.tagViewHeight = hotCell.tagsView.frame.size.height;
        return hotCell;
    } else {
        if (indexPath.section == 0) {
            HotSerachCell *hotCell = [tableView dequeueReusableCellWithIdentifier:HotCellID forIndexPath:indexPath];
            hotCell.tagsView.delegate = self;
            hotCell.selectionStyle = UITableViewCellSelectionStyleNone;
            hotCell.userInteractionEnabled = YES;
            hotCell.hotSearchArr = self.HotArr;
            /** 将通过数组计算出的tagV的高度存储 */
            self.tagViewHeight = hotCell.tagsView.frame.size.height;
            return hotCell;
        } else {
            HistorySearchCell *HistoryCell = [tableView dequeueReusableCellWithIdentifier:HistoryCellID forIndexPath:indexPath];
            HistoryCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            HistoryCell.titleLabel.text = self.historyArr[indexPath.row];
            
            [HistoryCell.removeButton addTarget:self action:@selector(removeSingleTagClick:) forControlEvents:UIControlEventTouchUpInside];
            HistoryCell.removeButton.tag = 250 + indexPath.row;
            return HistoryCell;
        }
    }
}

/** HeaderView */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 45)];
    headView.backgroundColor = [UIColor colorWithWhite:0.922 alpha:1.000];
    for (UILabel *lab in headView.subviews) {
        [lab removeFromSuperview];
    }
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, [UIScreen mainScreen].bounds.size.width - 10, 45)];
    titleLab.textColor = [UIColor colorWithWhite:0.229 alpha:1.000];
    titleLab.font = [UIFont systemFontOfSize:14];
    [headView addSubview:titleLab];
    if (self.historyArr.count == 0) {
        titleLab.text = @"热门搜索";
    } else {
        if (section == 0) {
            titleLab.text = @"热门搜索";
        } else {
            titleLab.text = @"搜索历史";
        }
    }
    return headView;
}

/** FooterView */
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section == 1) {
        UIButton *removeAllHistory = [UIButton buttonWithType:0];
        removeAllHistory.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 46);
        removeAllHistory.backgroundColor = [UIColor whiteColor];
        [removeAllHistory setTitleColor:[UIColor colorWithRed:1.000 green:0.058 blue:0.000 alpha:1.000] forState:0];
        [removeAllHistory setTitle:@"清除所有搜索记录" forState:0];
        removeAllHistory.titleLabel.font = [UIFont systemFontOfSize:16];
        [removeAllHistory addTarget:self action:@selector(removeAllHistoryBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        return removeAllHistory;
    } else {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.1)];
        return view;
    }
}

/** 头部的高 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}

/** cell的高 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.historyArr.count == 0) {
        return self.tagViewHeight + 40;
    } else {
        if (indexPath.section == 0) {
            return self.tagViewHeight + 40;
        } else {
            return 46;
        }
    }
}

/** FooterView的高 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.historyArr.count == 0) {
        return 0.1;
    } else {
        if (section == 0) {
            return 0.1;
        } else {
            return 46;
        }
    }
}

#pragma mark - 懒加载

- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableview registerClass:[HotSerachCell class] forCellReuseIdentifier:HotCellID];
        [_tableview registerNib:[UINib nibWithNibName:@"HistorySearchCell" bundle:nil] forCellReuseIdentifier:HistoryCellID];
        _tableview.backgroundColor = [UIColor colorWithWhite:0.934 alpha:1.000];
    }
    return _tableview;
}

//textfield的代理方法：自行写逻辑

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

#pragma mark - 实现点击热门搜索tag

- (void)TagsView:(UIView *)tagsView fetchWordToTextFiled:(NSString *)KeyWord {
    self.searchBar.text = KeyWord;
}

#pragma mark - 删除所有的历史记录

-(void)removeAllHistoryBtnClick{
    
    [self.historyArr removeAllObjects];
    [self.tableview reloadData];
}

#pragma mark - 删除单个搜索历史

-(void)removeSingleTagClick:(UIButton *)removeBtn {
    
    [self.historyArr removeObjectAtIndex:removeBtn.tag - 250];
    [self.tableview reloadData];
}

- (void)searchAction {
    self.parentViewController.navigationController.navigationBar.hidden = NO;
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

@end

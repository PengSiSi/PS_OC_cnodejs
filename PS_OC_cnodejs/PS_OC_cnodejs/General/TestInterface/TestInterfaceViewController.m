//
//  TestInterfaceViewController.m
//  wisdomClass
//
//  Created by 王楠 on 2017/6/29.
//  Copyright © 2017年 combanc. All rights reserved.
//

#import "TestInterfaceViewController.h"
#import "HTTPTool.h"
#import "PlistManager.h"
#import "UIBarButtonItem+Base.h"

NSString *const TestInterfaceCellID = @"TestInterfaceCellID";
@interface TestInterfaceViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSString *userName;
    NSString *password;
    NSString *urlStr;
    NSDictionary *paraDic;
}
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, copy) NSArray *dataArray;

@end

@implementation TestInterfaceViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"接口测试";
    
    _dataArray = @[@"1.登录", @"2.1 获取全部科目", @"2.2.1 作业列表", @"2.2.1 考试列表", @"2.2.2 作业详情", @"2.2.2 考试详情", @"3.1.1 互动答疑获取全部列表", @"3.1.3 单个答疑/提问的详情 （这个相当于是获取回答/回复的列表", @"4.2 获取（全部）或指定科目对应的微课程列表", @"4.3 微课程详情的基本信息", @"5.2 错题集", @"5.3.1 积分排行榜"];
    
    userName = @"010109";
    password = @"1";
    urlStr = @"";
    paraDic = @{};
    
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self addCancleNavBtn];
}

- (void)addCancleNavBtn {
    UIBarButtonItem *cancleItem = [UIBarButtonItem itemWithImage:nil higlightedImage:nil title:@"取消" target:self action:@selector(cancle)];
    [self.navigationItem setLeftBarButtonItem:cancleItem];
}

- (void)cancle {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TableView

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        // 登录
        urlStr = LOGININ_URL;
        paraDic = LoginParameter(userName, password, timeSt, APPKEY, VERSION, VERIFY);
    }else if (indexPath.row == 1) {
        // 获取全部科目
        urlStr = WEIKE_SUBJECTLIST_URL;
        paraDic = WeikeSubjectList(userName, timeSt, APPKEY, VERSION, VERIFY);
    }else if (indexPath.row == 2) {
        // 作业列表
        urlStr = HOMEWORK_getPageBenWork_URL;
        paraDic = HomeworkgetPageBenWork(userName, @"4", @"0", @"", @"", @1, @10, timeSt, APPKEY, VERSION, VERIFY);
    }else if (indexPath.row == 3) {
        // 考试列表
        urlStr = HOMEWORK_getPageBenWork_URL;
        paraDic = HomeworkgetPageBenWork(userName, @"3", @"0", @"", @"", @1, @10, timeSt, APPKEY, VERSION, VERIFY);
    }else if (indexPath.row == 4) {
        // 作业详情
        urlStr = HOMEWORK_getPhoneWorkPojo_URL;
        paraDic = HomeworkGetPhoneWorkPojobyidParameter(userName, @"4", @"4028b2165c10afa7015c38eaed8405e1", timeSt, APPKEY, VERSION, VERIFY);
    }else if (indexPath.row == 5) {
        // 考试详情
        urlStr = HOMEWORK_getPhoneWorkPojo_URL;
        paraDic = HomeworkGetPhoneWorkPojobyidParameter(userName, @"3", @"4028b2165c10afa7015c38eaed8405e1", timeSt, APPKEY, VERSION, VERIFY);
    }else if (indexPath.row == 6) {
        // 3.1.1 获取全部互动答疑列表（获取单个试题或微课程的提问列表）
        urlStr = QUESTIONANSWER_getPageBeanForum_URL;
        paraDic = QuestionAnswerGetPageBeanForumParameter(userName, @"", @"", @"", @"", @"", @"", @50, @1, timeSt, APPKEY, VERSION, VERIFY);
        
    }else if (indexPath.row == 7) {
        // 3.1.3 单个答疑/提问的详情 （这个相当于是获取回答/回复的列表
        urlStr = QUESTIONANSWER_getSingleForum_URL;
        paraDic = QuestionAnswerGetForum(userName, @"4028b2165c10afa7015c3eadab000641", @1, @10, timeSt, APPKEY, VERSION, VERIFY);
    }else if (indexPath.row == 8) {
        // 4.2 获取（全部）或指定科目对应的微课程列表
        urlStr = WEIKE_getPageBenWeiKeChengPojo_URL;
        paraDic = WeikeGetPageBenWeiKeChengPojo(userName, @"", @1, @10, timeSt, APPKEY, VERSION, VERIFY);
    }else if (indexPath.row == 9) {
        // 4.3 微课程详情的基本信息
        urlStr = WEIKE_getWeiKeChengPojoById_URL;
        paraDic = WeikeGetWeiKeChengPojoById(userName, @"4028b2165bc87bc5015bf69103cb028a", timeSt, APPKEY, VERSION, VERIFY);
    }else if (indexPath.row == 10) {
        // 5.2 错题集
        urlStr = MINE_getWorkQuestionErrorPageBean_URL;
        paraDic = MineGetWorkQuestionErrorPageBean(userName, @"", @1, @10, timeSt, APPKEY, VERSION, VERIFY);
    }else if (indexPath.row == 11) {
        // 5.3.1 积分排行榜
        urlStr = MINE_getListStudentScore_URL;
        paraDic = MineGetListStudentScore(userName, timeSt, APPKEY, VERSION, VERIFY);
    }else if (indexPath.row == 12) {
        //
        
    }
    
    
    [HTTPTool postWithURL:urlStr headers:nil params:paraDic success:^(id json) {
        
        [PlistManager plistManagerSaveDic:json jsonName:_dataArray[indexPath.row]];
        
        NSLog(@"json: %@", json);
        if (KRETURNCODE(json[@"code"])) {
            
        }else{
            
        }
        
    } failure:^(NSError *error) {
        [CombancHUD showErrorWithError:error];
    }];

    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TestInterfaceCellID forIndexPath:indexPath];
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}


#pragma mark - Setter

- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TestInterfaceCellID];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        
    }
    return _myTableView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

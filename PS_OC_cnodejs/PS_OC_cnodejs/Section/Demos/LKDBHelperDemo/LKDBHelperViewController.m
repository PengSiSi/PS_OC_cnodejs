

//
//  LKDBHelperViewController.m
//  PS_OC_cnodejs
//
//  Created by 思 彭 on 2018/2/2.
//  Copyright © 2018年 思 彭. All rights reserved.

// 参考博客： http://blog.csdn.net/potato512/article/details/51165519

#import "LKDBHelperViewController.h"
#import <LKDBHelper.h>
#import "LKDBModel.h"

#define SQLiteFile @"SQLiteFile.db"

@interface LKDBHelperViewController ()

@property (nonatomic, copy) NSString *filePath;
@property (nonatomic, strong) LKDBHelper *dbHelper;
@property (nonatomic, strong) LKDBModel *userModel;

@end

@implementation LKDBHelperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self createTable];
   
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"进入了主线程");
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"再次进入了主线程");
        });
    });
}

// 数据库路径
- (NSString *)filePath {
    if (!_filePath) {
        // document目录下
        NSArray *documentArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
        NSString *document = [documentArray objectAtIndex:0];
        _filePath = [document stringByAppendingPathComponent:SQLiteFile];
    }
    NSLog(@"filePath = %@", _filePath);
    return _filePath;
}

// 实例化
- (LKDBHelper *)dbHelper {
    if (!_dbHelper) {
        _dbHelper = [[LKDBHelper alloc]initWithDBPath:self.filePath];
        [_dbHelper dropAllTable];
    }
    return _dbHelper;
}

// 创建表
- (void)createTable {
    BOOL result = [self.dbHelper getTableCreatedWithClass:[LKDBModel class]];
    if (result) {
        NSLog(@"创建表成功");
    } else {
        NSLog(@"创建表失败");
    }
}

// 插入数据
- (void)insertData {
    LKDBModel *model = [[LKDBModel alloc]init];
    model.name = @"sisi";
    model.phone = @"1111111";
    model.addredss = @"北京市";
    BOOL result = [self.dbHelper insertToDB:model];
    if (result) {
        NSLog(@"插入数据成功");
    } else {
        NSLog(@"插入数据失败");
    }
}

// 更新数据
- (void)updateData {
    // 查找的条件
    NSString *where = @"name = 'sisi'";
    NSString *orderBy = @"name asc";  // 升序
    [self.dbHelper search:[LKDBModel class] where:where orderBy:orderBy offset:0 count:100 callback:^(NSMutableArray * _Nullable array) {
        if (array && 0 != array.count) {
            for (LKDBModel *model in array) {
                NSLog(@"更新数据成功：name=%@, address=%@", model.name, model.addredss);
                if ([model.name isEqualToString:@"sisi"]) {
                    self.userModel = model;
                }
            }
        } else {
            NSLog(@"更新查找数据失败");
        }
    }];
    if (self.userModel) {
        self.userModel.name = @"PengSi";
        self.userModel.addredss = @"湖南";
        BOOL result =  [self.dbHelper updateToDB:self.userModel where:nil];
        if (result) {
            NSLog(@"更细数据成功");
        } else {
            NSLog(@"更新数据失败");
        }
    } else {
        NSLog(@"更新数据失败");
    }
}

// 查找数据
- (void)findData {
    // 查找条件
    NSString *where = nil;
    NSString *orderBy = nil;
    [self.dbHelper search:[LKDBModel class] where:where orderBy:orderBy offset:0 count:100 callback:^(NSMutableArray * _Nullable array) {
        if (array && 0 != array.count) {
            for (LKDBModel *model in array) {
                NSLog(@"查找数据成功：name = %@, address = %@", model.name, model.addredss);
                if ([model.name isEqualToString:@"sisi"]) {
                    self.userModel = model;
                }
            }
        } else {
            NSLog(@"查找数据失败");
        }
    }];
}

// 删除数据
- (void)deleteData {
    [self.dbHelper deleteToDB:self.userModel callback:^(BOOL result) {
        if (result) {
            NSLog(@"删除数据成功");
        } else {
            NSLog(@"删除数据失败");
        }
    }];
}

// 删除表
- (void)deleteTable {
    BOOL result = [self.dbHelper dropTableWithClass:[LKDBModel class]];
    if (result) {
        NSLog(@"删除表成功");
    } else {
        NSLog(@"删除表失败");
    }
}

@end

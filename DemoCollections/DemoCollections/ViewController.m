//
//  ViewController.m
//  DemoCollections
//
//  Created by helong on 16/8/20.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "ViewController.h"
#import "HLDetailViewController.h"
#import "HLMainModel.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *leftTable;
//  模型数组
@property (strong, nonatomic) NSArray <HLMainModel *>*tableModelArray;
//  记录点击cell的索引
@property (assign, nonatomic) NSInteger index;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"DemoCollection";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self configureUI];
}
/**
 *  初始化UI
 */
- (void)configureUI {
    //  左边的tableView
    self.leftTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.leftTable.delegate = self;
    self.leftTable.dataSource = self;
    self.leftTable.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.leftTable];
    //  设置约束
    [self.leftTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
    }];
    
}

#pragma mark - 数据源代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableModelArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    cell.backgroundColor = [UIColor randomColor];
    cell.textLabel.text = self.tableModelArray[indexPath.row].title;
    return cell;
}
/**
 *  选中cell的代理方法
 *  在里面设置跳转的目标控制器
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //  根据plist文件的字符串转化成类
    NSString *controllerString = self.tableModelArray[indexPath.row].targetVC;
    Class class = NSClassFromString(controllerString);
    UIViewController *targetVC = [[class alloc] init];
    //  设置目标控制器的标题
    targetVC.navigationItem.title = self.tableModelArray[indexPath.row].title;
    self.index = indexPath.row;

    
    //  设置目标控制器的右边按钮,并添加事件
    targetVC.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"详情" style:UIBarButtonItemStylePlain target:self action:@selector(detailInfos)];
    
    
    [self.navigationController pushViewController:targetVC animated:YES];
    
}

#pragma mark - 导航栏右边按钮的点击事件
/**
 *  rightBarButtonItem点击事件
 */
- (void)detailInfos {
    HLDetailViewController *detailVC = [[HLDetailViewController alloc] init];
    detailVC.detailInfos = self.tableModelArray[self.index].detailInfos;
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载
/**
 *  懒加载并实施字典转模型
 */
- (NSArray *)tableModelArray {
    if (!_tableModelArray) {
        _tableModelArray = [NSArray array];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"tables.plist" ofType:nil];
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            HLMainModel *model = [HLMainModel mainModelWithDictionary:dict];
            [tempArr addObject:model];
        }
        _tableModelArray = tempArr.copy;
    }
    return _tableModelArray;
}
@end

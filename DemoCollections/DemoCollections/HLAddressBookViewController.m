//
//  HLAddressBookViewController.m
//  DemoCollections
//
//  Created by helong on 2016/9/27.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLAddressBookViewController.h"
#import "CarModel.h"
#import "CarSectionModel.h"

@interface HLAddressBookViewController ()<UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate,UISearchResultsUpdating>
// 汽车分组数据
@property(strong,nonatomic) NSArray *carSectionInfos;
@property (nonatomic, weak) UISearchBar *search;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, weak) UITableView *ADBookTable;
@property (nonatomic, strong) NSMutableArray *searchList;
@end

@implementation HLAddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureUI];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searcContact)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(searcContact)];
    self.navigationItem.rightBarButtonItems = @[item1,item2];
    UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController = searchController;
    searchController.dimsBackgroundDuringPresentation = NO;
    searchController.hidesNavigationBarDuringPresentation = NO;
    searchController.searchResultsUpdater = self;
    searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    self.ADBookTable.tableHeaderView = searchController.searchBar;
}
- (void)searcContact{
//    NSLog(@"%@",NSStringFromCGRect(self.navigationController.view.frame));
//    UISearchBar *search = [[UISearchBar alloc] init];
//    [self.navigationController.view addSubview:search];
//    search.delegate = self;
//    search.placeholder = @"搜索";
//    self.search = search;
//    [search mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.trailing.bottom.top.mas_equalTo(self.navigationController.view);
//    }];
    
}
- (void)configureUI {
//    UISearchBar *search = [[UISearchBar alloc] init];
//    [self.view addSubview:search];
//    search.delegate = self;
//    search.placeholder = @"搜索";
//    self.search = search;
//    
    
    UITableView *ADBookTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:ADBookTable];
    ADBookTable.delegate = self;
    ADBookTable.dataSource = self;
    self.ADBookTable = ADBookTable;
//    [search mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.leading.trailing.mas_equalTo(self.view);
//        make.height.mas_equalTo(44);
//    }];
    
    [ADBookTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.leading.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
    }];
}

#pragma mark - search的代理方法
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [UIView animateWithDuration:0.5 animations:^{
        self.search.showsCancelButton = YES;
    }];
    
}
///按回车或者键盘上的额搜索键触发的事件
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
     NSLog(@"%@",searchBar.text);
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = @"";
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchString = [self.searchController.searchBar text];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    //过滤数据
    self.searchList= [NSMutableArray arrayWithArray:[self.carSectionInfos filteredArrayUsingPredicate:preicate]];
    //刷新表格
    [self.ADBookTable reloadData];
}
#pragma mark -- 数据源方法实现
// 设置区域的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    // 数据模型的 最外层 数组 的个数 就是 区域的个数
    if (self.searchController.active) {
        return 1;
    }else {
    return self.carSectionInfos.count;
    }
}
// 设置区域中的 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // 获取 是第几个区域
    // 根据section 获取 对应的 区域model
    if (self.searchController.active) {
        return self.searchList.count;
    }else {
        
        CarSectionModel *sectionModel = self.carSectionInfos[section];
        // 返回 .cars 属性 中的 元素 个数
        return sectionModel.cars.count;
    }
}
// 设置每一行的 外观
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *key = @"car";
    // 创建Cell(可重用的Cell)
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:key];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:key];
    }
    
    // 设置Cell
    // 每一个Cell 的外观 是有 carModel决定
    // carModel 在 carSectionModel.cars中
    // 先获取 组模型
    CarSectionModel *sectionModel = self.carSectionInfos[indexPath.section];
    // 再获取 car模型
    CarModel *carModel = sectionModel.cars[indexPath.row];
    
    // 设置图片
    cell.imageView.image = [UIImage imageNamed:carModel.icon];
    // 设置名字
    cell.textLabel.text = carModel.name;
    
    // 返回Cell
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
// 设置区域的顶部标题
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    // 使用Section 获取 区域模型
    CarSectionModel *sectionModel = self.carSectionInfos[section];
    // 返回 区域模型的 title属性
    return sectionModel.title;
}

// 设置索引的 数据源方法
/*
 方法对了
 索引 跟 标题的名字 有没有关系? 没有
 索引栏,是跟区域的 一个 索引对应关系,
 
 */
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    // 使用 可变 数组 来 添加索引
    NSMutableArray *mutArr = [NSMutableArray array];
    for (CarSectionModel *sectionModel in self.carSectionInfos) {
        // 获取 title属性
        NSString *title = sectionModel.title;
        // 添加到可变数组
        [mutArr addObject:title];
    }
    // 返回
    return mutArr;
}


#pragma mark -- 懒加载数据

- (NSArray *)carSectionInfos{
    // 判断
    if (_carSectionInfos == nil) {
        // 字典数组 (carSection的字典数组)
        NSArray *carSectionDictArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cars_total.plist" ofType:nil]];
        // 准备可变数组
        NSMutableArray *carSectionMutArr = [NSMutableArray array];
        for (NSDictionary *sectionDict in carSectionDictArr) {
            // 创建 carSection模型
            CarSectionModel *sectionModel = [CarSectionModel carSectionWithDict:sectionDict];
            
            // 循环 CZCarSectionModel.cars 去 字典转模型
            // 创建新的可变数组 用来 保存 我们 转换的carModel
            NSMutableArray *carsMutArr = [NSMutableArray array];
            for (NSDictionary *carDict in sectionModel.cars) {
                // 创建CarModel
                CarModel *carModel = [CarModel carWithDict:carDict];
                // 添加到可变数组
                [carsMutArr addObject:carModel];
            }
            // carsMutArr 在循环完毕以后 就有值了
            sectionModel.cars = carsMutArr;
            
            // 添加到可变数组中
            [carSectionMutArr addObject:sectionModel];
            
        }
        
        // 赋值给属性
        _carSectionInfos = carSectionMutArr;
    }
    return _carSectionInfos;
}

- (NSMutableArray *)searchList {
    if (!_searchList) {
        _searchList = [NSMutableArray array];
    }
    return _searchList;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

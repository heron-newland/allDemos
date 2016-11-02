//
//  HLHeaderAndFooterTableViewController.m
//  DemoCollections
//
//  Created by helong on 11/1/16.
//  Copyright © 2016 helong. All rights reserved.
//

#import "HLHeaderAndFooterTableViewController.h"

@interface HLHeaderAndFooterTableViewController ()
@property (nonatomic, strong) NSArray *dataSource;
//@property (nonatomic, weak) UIButton *laodBtn;
@property (nonatomic, strong) NSMutableArray *btnArr;
@end

@implementation HLHeaderAndFooterTableViewController
static NSString *const reuseID = @"reuseID";
static NSString *const reuseHeaderID = @"reuseHeaderID";
static NSString *const reuseFooterID = @"reuseFooterID";
- (instancetype)init {
    if (self = [super init]) {
        self.tableView = [[UITableView alloc] initWithFrame:self.tableView.frame style:UITableViewStyleGrouped];
         [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseID];
        [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:reuseFooterID];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = self.dataSource[section];
    return arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     NSArray *arr = self.dataSource[indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    cell.textLabel.text = arr[indexPath.row];
    // Configure the cell...
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    UITableViewHeaderFooterView *view = [tableView footerViewForSection:section];
//    NSLog(@"%@",view.textLabel.text);
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseFooterID];
    view.textLabel.text = @"footer";

    view.contentView.backgroundColor = [UIColor redColor];
    if (section == 0) {
        view.hidden = YES;
//        tableView.sectionFooterHeight = 20;
    }else {
//        tableView.sectionFooterHeight = 55;
    }
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
     UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseFooterID];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 200, 0, 200, 44)];
    [view.contentView addSubview:btn];
    [btn setTitle:@"点击加载更多" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.tag = section;
    [self.btnArr addObject:btn];

    [btn setBackgroundColor:[UIColor yellowColor]];
    [btn addTarget:self action:@selector(loadMore:) forControlEvents:UIControlEventTouchUpInside];
    return view;
}

- (void)loadMore:(UIButton *)sender {
    for (UIButton *btn in self.btnArr) {
        NSLog(@"%ld",(long)btn.tag);
        if (btn.tag == sender.tag) {
            
            if ([btn.titleLabel.text isEqualToString:@"没有更多数据"]) {
                
                [btn setTitle:@"点击加载更多" forState:UIControlStateNormal];
            }else {
                [btn setTitle:@"没有更多数据" forState:UIControlStateNormal];
            }
        }
    }
    //下面的方法刷新section包含section的头部和脚部
//    NSIndexSet *set = [NSIndexSet indexSetWithIndex:sender.tag];
//    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
    
    //下面的方法刷新section里面的cell,不包含头部和脚部
    NSMutableArray *mut = [NSMutableArray array];
   NSInteger count = [self.tableView numberOfRowsInSection:sender.tag];
    for (int i = 0; i<count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:sender.tag];
        [mut addObject:indexPath];
    }
        [self.tableView reloadRowsAtIndexPaths:mut withRowAnimation:UITableViewRowAnimationFade];
}
#pragma mark - lazy load
- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[@[@"A",@"B",@"C"],@[@"D",@"E"],@[@"F"]];
    }
    return _dataSource;
}
- (NSMutableArray *)btnArr {
    if (!_btnArr) {
        _btnArr = [NSMutableArray array];
    }
    return _btnArr;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

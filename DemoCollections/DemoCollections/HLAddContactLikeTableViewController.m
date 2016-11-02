//
//  HLAddContactLikeTableViewController.m
//  DemoCollections
//
//  Created by helong on 2016/10/16.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLAddContactLikeTableViewController.h"

@interface HLAddContactLikeTableViewController ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation HLAddContactLikeTableViewController
 static NSString *reuserIdentifier = @"reuserIdentifier";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    for (int  i = 0; i<3; i++) {
        NSString *str = [NSString stringWithFormat:@"%d",i + 1000];
        [self.dataArray addObject:str];
    }
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuserIdentifier];
    
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

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuserIdentifier];
//    }
    cell.textLabel.text = self.dataArray[indexPath.row];
//     Configure the cell...
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
   
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 100, 55)];
    [addBtn setTitle:@"添加联系人" forState:UIControlStateNormal];
    [addBtn setBackgroundColor:[UIColor greenColor]];
    [addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addBtn.titleLabel setFont:[UIFont systemFontOfSize:20 weight:UIFontWeightBold]];
    
    [addBtn addTarget:self action:@selector(addContact:) forControlEvents:UIControlEventTouchUpInside];
    return addBtn;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
#warning 设置headerview的正确方式,重复利用, 以前都是错的
    UITableViewHeaderFooterView *headerView  = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (!headerView) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"header"];
        
        headerView.backgroundColor = [UIColor blueColor];
        UIButton *editBtn = [[UIButton alloc] init];
        [editBtn setTitle:@"编辑联系人" forState:UIControlStateNormal];
        [editBtn setBackgroundColor:[UIColor greenColor]];
        [editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [editBtn.titleLabel setFont:[UIFont systemFontOfSize:20 weight:UIFontWeightBold]];
        [editBtn addTarget:self action:@selector(editContact:) forControlEvents:UIControlEventTouchUpInside];
        [headerView.contentView addSubview:editBtn];
        [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.mas_equalTo(headerView).insets(UIEdgeInsetsMake(0, 300, 0, 0));
        }];
        
    }
    
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}
- (void)editContact:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"编辑联系人"]) {
        
        [self.tableView setEditing:YES animated:YES];
        [sender setTitle:@"完成" forState:UIControlStateNormal];
    }else {
//    if ([sender.titleLabel.text isEqualToString:@"完成"]) {
        
        [self.tableView setEditing:NO animated:YES];
        [sender setTitle:@"编辑联系人" forState:UIControlStateNormal];
    }
}
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *action  = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }];
    
                                     
    return @[action];
}
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"edn");
}
- (void)addContact:(UIButton *)sender {
    [self.dataArray addObject:@"100000111"];
    [self.tableView reloadData];
    NSLog(@"添加联系人");
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
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

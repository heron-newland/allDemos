//
//  HLEditingTableViewController.m
//  DemoCollections
//
//  Created by helong on 2016/10/11.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLEditingTableViewController.h"
#import "HLAddContactLikeTableViewController.h"
@interface HLEditingTableViewController ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation HLEditingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:30];
    for (int  i = 0; i<3; i++) {
        NSString *str = [NSString stringWithFormat:@"%d",i + 1000];
        [self.dataArray addObject:str];
    }
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"allCell"];
    //  开启cell的编辑
    [self.tableView setEditing:YES animated:YES];

#warning  如果tableView的cell很少空白的部分会有横线,给footerview设置一个view可以解决问题
    UIView *footer = [[UIView alloc] init];
    footer.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = footer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"allCell" forIndexPath:indexPath];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"allCell"];
//    }
    // Configure the cell...
    cell.textLabel.text  = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    HLAddContactLikeTableViewController *addContactViewController = [[HLAddContactLikeTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.navigationController pushViewController:addContactViewController animated:YES];
    NSLog(@"%@",cell.textLabel.text);
}
/// 向左滑动能出现响应的按钮操作
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }];
                                     
    UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"刷新" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        [self.dataArray removeObjectAtIndex:indexPath.row];
//        [self.tableView setEditing:YES animated:YES];
        [self.tableView reloadData];
    }];
    UITableViewRowAction *action3 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"忽略" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        //        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView setEditing:NO animated:YES];
        [self.tableView reloadData];
    }];
    NSArray *arr = @[action1,action2,action3];
    return arr;
}
/// 该方法允许移动cell, 并且在移动cell的时候要在此方法中更新数据源
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    [self.dataArray exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
    
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

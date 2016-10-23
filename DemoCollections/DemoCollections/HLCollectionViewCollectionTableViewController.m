//
//  HLCollectionViewCollectionTableViewController.m
//  DemoCollections
//
//  Created by helong on 2016/10/22.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLCollectionViewCollectionTableViewController.h"
#import "HLMoveItemCollectionViewController.h"
#import "HLFlowLayoutViewController.h"
#import "HLPullDownFlowLayoutCollectionViewController.h"
#import "HLPullDownFlowLayout.h"

@interface HLCollectionViewCollectionTableViewController ()
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation HLCollectionViewCollectionTableViewController
static NSString *reuseIdentifierForCell = @"reuseIdentifierForCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor whiteColor];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifierForCell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierForCell forIndexPath:indexPath];
    
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifierForCell];
//    }
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(kScreenWidth/3, kScreenWidth/3);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;

        HLMoveItemCollectionViewController *moveVC = [[HLMoveItemCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
        
        [self.navigationController pushViewController:moveVC animated:YES];
    }
    if (indexPath.row == 1) {
        HLFlowLayoutViewController *moveVC = [[HLFlowLayoutViewController alloc] init];
        [self.navigationController pushViewController:moveVC animated:YES];
    }
    if (indexPath.row == 2) {
        HLPullDownFlowLayout *flowLayout = [[HLPullDownFlowLayout alloc] init];
//        flowLayout.itemSize = CGSizeMake(kScreenWidth/3, kScreenWidth/3);
//        flowLayout.minimumLineSpacing = 0;
//        flowLayout.minimumInteritemSpacing = 0;
        
        HLPullDownFlowLayoutCollectionViewController *moveVC = [[HLPullDownFlowLayoutCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
        
        [self.navigationController pushViewController:moveVC animated:YES];
    }
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
#pragma mark - 懒加载数据源
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithArray:@[@"移动重排,header,footer",@"流自定义流水布局相册",@"下拉流水布局",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15"]];
    }
    return _dataSource;
}
@end

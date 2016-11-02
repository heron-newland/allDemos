//
//  HLGeneralTableViewController.m
//  DemoCollections
//
//  Created by helong on 11/1/16.
//  Copyright © 2016 helong. All rights reserved.
//

#import "HLGeneralTableViewController.h"
#import "HLEditingTableViewController.h"
#import "HLAddressBookViewController.h"
#import "HLHeaderAndFooterTableViewController.h"

@interface HLGeneralTableViewController ()
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation HLGeneralTableViewController
static NSString *const reuseID = @"reuseID";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseID];
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



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseID];
//    }
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row ==0) {
        HLEditingTableViewController *editVC = [[HLEditingTableViewController alloc] init];
        [self.navigationController pushViewController:editVC animated:YES];
    }else if (indexPath.row == 1){
        HLAddressBookViewController *addVC = [[HLAddressBookViewController alloc] init];
        [self.navigationController pushViewController:addVC animated:YES];
    }else if (indexPath.row ==2){
        HLHeaderAndFooterTableViewController *headVC = [[HLHeaderAndFooterTableViewController alloc] init];
        [self.navigationController pushViewController:headVC animated:YES];
    }
}
#pragma mark - lazy load
- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[@"编辑cell",@"联系人",@"编辑头部和脚部"];
    }
    return _dataSource;
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

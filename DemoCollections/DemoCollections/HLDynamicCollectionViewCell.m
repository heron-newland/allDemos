//
//  HLDynamicCollectionViewCell.m
//  DemoCollections
//
//  Created by helong on 16/9/8.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLDynamicCollectionViewCell.h"
#import "HLDynamicTableViewCell.h"

@interface HLDynamicCollectionViewCell ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@end

@implementation HLDynamicCollectionViewCell
static NSString *resuableTableCell = @"resuableTableCell";
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureUI];
    }
    return self;
}
- (void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
#warning 没有此句代码tableview 不会自动刷新
    [self.tableView reloadData];
}
- (void)configureUI {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self addSubview:tableView];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
//    [self.tableView registerClass:[HLDynamicTableViewCell class] forCellReuseIdentifier:resuableTableCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"HLdycell" bundle:nil] forCellReuseIdentifier:resuableTableCell];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HLDynamicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:resuableTableCell];
    if (!cell) {
      cell = [[HLDynamicTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:resuableTableCell];
    }
    cell.titleArray = self.titleArray;
    cell.perArray = self.perArray;
    
    cell.backgroundColor = [UIColor randomColor];
    return cell;
}
@end

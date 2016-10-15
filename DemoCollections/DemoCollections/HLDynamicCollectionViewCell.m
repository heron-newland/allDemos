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
@property (nonatomic, weak) UIView *chartView;
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
    
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [UIColor randomColor];
    [self.contentView addSubview:titleView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.contentView addSubview:tableView];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    
//    [self.tableView registerClass:[HLDynamicTableViewCell class] forCellReuseIdentifier:resuableTableCell];
    [self.tableView registerNib:[UINib nibWithNibName:@"HLdycell" bundle:nil] forCellReuseIdentifier:resuableTableCell];
    
    UIView *chartView = [[UIView alloc] init];
    chartView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:chartView];
    self.chartView = chartView;
    
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(49);
        make.leading.trailing.mas_equalTo(self.contentView);
//        make.bottom.mas_equalTo(chartView.mas_top);
        make.height.mas_equalTo(50);
    }];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleView.mas_bottom);
        make.leading.trailing.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(chartView.mas_top);
    }];
    
    [chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(200);
    }];
    
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

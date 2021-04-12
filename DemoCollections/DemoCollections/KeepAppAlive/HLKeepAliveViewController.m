//
//  HLKeepAliveViewController.m
//  DemoCollections
//
//  Created by 李白 on 2021/3/6.
//  Copyright © 2021 helong. All rights reserved.
//

#import "HLKeepAliveViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "HLAudioManager.h"
#import "HLLocationManager.h"
#import "HLTemporary.h"


@interface HLKeepAliveViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic,weak)UITableView *tableView;
@property(nonatomic,copy)NSMutableArray *data;

@end

NSString *cellID = @"cellID";
@implementation HLKeepAliveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
#if kShouldKeepAliveWorks
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"为了测试请选择始终允许" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertVC addAction:action];
    [self presentViewController:alertVC animated:true completion:nil];
#endif
  
    // Do any additional setup after loading the view.
    UITableView *tableView_ = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView = tableView_;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    
    #if kShouldKeepAliveWorks
    [[HLLocationManager singleton] requestAuthority];
#endif
}


- (void)switchAction:(UISwitch *)sender {
    if (sender.tag == 1) {
        [HLAudioManager singleton].available = sender.on;
    }else if(sender.tag == 0) {
        if (sender.on) {
            [[HLLocationManager singleton] start];
        }else{
            [[HLLocationManager singleton] stop];
        }
    }else if (sender.tag == 2) {
        [HLTemporary singleton].available = sender.on;
    }
}

#pragma mark - tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = self.data[indexPath.row];
    cell.textLabel.text = dic.allKeys[0];
    UISwitch *switch_ = [[UISwitch alloc] initWithFrame:CGRectZero];
//    switch_.userInteractionEnabled = false;
    [cell.contentView addSubview:switch_];
    switch_.tag = indexPath.row;
    [switch_ addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
//    switch_.on = [dic.allValues[0] boolValue];
    [switch_ setOn:[dic.allValues[0] boolValue]];
    [switch_ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(cell.contentView.mas_trailing).offset(-12);
        make.centerY.mas_equalTo(cell.contentView.mas_centerY);
    }];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dic in self.data) {
        NSDictionary *tmpDic = [NSDictionary dictionaryWithObject:@0 forKey:dic.allKeys[0]];
        [arr addObject:tmpDic];
    }
    self.data = arr;

}
- (NSMutableArray *)data {
    if (!_data) {
        _data = [NSMutableArray arrayWithArray:@[
            @{@"持续定为":@0},
            @{@"后台播放音乐":@0},
            @{@"短时保活":@0},
            
        ]];
    }
    return _data;
}
@end

//
//  HLGestureViewController.m
//  DemoCollections
//
//  Created by helong on 16/8/24.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLGestureViewController.h"
#import "HLGestureView.h"
#import "HLDetailViewController.h"
@interface HLGestureViewController ()

@end

@implementation HLGestureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //  配置界面
    [self configureUI];
    
     self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"HomeButtomBG"]];
  
}
- (void)configureUI{
    HLGestureView *gesture = [[HLGestureView alloc] init];
    [self.view addSubview:gesture];
    //  添加约束
    [gesture mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
        make.width.equalTo(@(self.view.width * 0.8));
        make.height.equalTo(@(self.view.width * 0.8));
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

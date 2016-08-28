//
//  HLEyeViewController.m
//  DemoCollections
//
//  Created by helong on 16/8/27.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLEyeViewController.h"
#import "HLEyeView.h"

@interface HLEyeViewController ()
@property (nonatomic, weak) UIView *containerView;
@end

@implementation HLEyeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    HLEyeView *containerView = [[HLEyeView alloc] init];
//    containerView.backgroundColor = [UIColor greenColor];
    self.containerView = containerView;
    [self.view addSubview:containerView];
    
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.equalTo(@300);
    }];
    
   
    
//    [containerView drawEye];
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

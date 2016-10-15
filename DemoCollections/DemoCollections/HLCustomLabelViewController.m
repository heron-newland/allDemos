//
//  HLCustomLabelViewController.m
//  DemoCollections
//
//  Created by helong on 2016/9/26.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLCustomLabelViewController.h"
#import "HLLabel.h"

@interface HLCustomLabelViewController ()

@end

@implementation HLCustomLabelViewController
NS_INLINE int get(){
    return 12;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    HLLabel *insetsLabel = [[HLLabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44) andInsets:UIEdgeInsetsMake(0, 0, 0, 40)];
    insetsLabel.text = @"我爱中国";
    insetsLabel.textAlignment = NSTextAlignmentRight;
    insetsLabel.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:insetsLabel];
    
    
    [insetsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(64);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(44);
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

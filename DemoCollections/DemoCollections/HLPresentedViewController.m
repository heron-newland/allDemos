//
//  HLPresentedViewController.m
//  DemoCollections
//
//  Created by helong on 2016/10/30.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLPresentedViewController.h"
#import "HLConstrainView.h"
@interface HLPresentedViewController ()
@property (nonatomic, strong) UILabel *label;
@end

@implementation HLPresentedViewController
- (void)loadView {
    [super loadView];
    self.view = [[HLConstrainView alloc] init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    UIView *myView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:myView];
    myView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.3];
    self.label = [[UILabel alloc] init];
    self.label.text = @"爱我中华";
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.label];

}

//- (void)viewWillLayoutSubviews {
//    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsMake(200, 30, 200, 30));
//    }];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)shouldAutorotate {
    return  YES;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
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

//
//  HLRotateScreenViewController.m
//  DemoCollections
//
//  Created by helong on 2016/10/30.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLRotateScreenViewController.h"
#import "HLPresentedViewController.h"

@interface HLRotateScreenViewController ()

@end

@implementation HLRotateScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    [self.view addSubview:myView];
    //这样设置只有该视图的透明度为0.5,他的子视图的透明度不受影响
    myView.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    //如果按照如下设置,那么该视图的所有子视图的透明度都为0.3
//    myView.backgroundColor = [UIColor blueColor];
//    myView.alpha = 0.3;
    UIView *my1View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 150)];
    my1View.backgroundColor = [UIColor redColor];
    [myView addSubview:my1View];
    // Do any additional setup after loading the view.
}
- (BOOL)shouldAutorotate {
    return  YES;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    HLPresentedViewController *presentedVC = [[HLPresentedViewController alloc] init];
    [self presentViewController:presentedVC animated:YES completion:nil];
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

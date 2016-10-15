//
//  HLWindowViewController.m
//  DemoCollections
//
//  Created by helong on 2016/10/15.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLWindowViewController.h"

@interface HLWindowViewController ()
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UIWindow *myWindow;
@end

@implementation HLWindowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    //创建悬浮按钮
    [self creatFloatButton];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_myWindow resignKeyWindow];
    _myWindow = nil;
}
- (void)creatFloatButton {
    //创建window
    _myWindow = [[UIWindow alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    _myWindow.backgroundColor = [UIColor redColor];
    _myWindow.windowLevel = UIWindowLevelAlert + 1;
    //创建btn放在window上
    _btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [_btn setTitle:@"点击隐藏" forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(dismissWindow) forControlEvents:UIControlEventTouchUpInside];
    [_myWindow addSubview:_btn];
    [_myWindow makeKeyAndVisible];
}

///移除window的方法
- (void)dismissWindow {
    [_myWindow resignKeyWindow];
    _myWindow = nil;
}
///在此创建window
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self creatFloatButton];
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

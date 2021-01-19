//
//  HLPresentEffectViewController.m
//  DemoCollections
//
//  Created by 李白 on 2021/1/6.
//  Copyright © 2021 helong. All rights reserved.
//

#import "HLPresentEffectViewController.h"
#import "HLPresentTestViewController.h"

@interface HLPresentEffectViewController ()

@end

@implementation HLPresentEffectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 100, 44)];
    btn1.backgroundColor = [UIColor greenColor];
    [btn1 setTitle:@"有动画" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(presentWithAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(200, 100, 100, 44)];
     btn2.backgroundColor = [UIColor redColor];
       [btn2 setTitle:@"无动画" forState:UIControlStateNormal];
       [btn2 addTarget:self action:@selector(presentWithOutAnimation) forControlEvents:UIControlEventTouchUpInside];
       [self.view addSubview:btn2];
    
}


- (void)presentWithAnimation {
    HLPresentTestViewController *vc = [[HLPresentTestViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:true completion:nil];
}

- (void)presentWithOutAnimation {
    HLPresentTestViewController *vc = [[HLPresentTestViewController alloc] init];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:vc animated:false completion:nil];
}

@end

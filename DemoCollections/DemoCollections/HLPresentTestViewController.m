//
//  HLPresentTestViewController.m
//  DemoCollections
//
//  Created by 李白 on 2021/1/6.
//  Copyright © 2021 helong. All rights reserved.
//

#import "HLPresentTestViewController.h"

@interface HLPresentTestViewController ()

@end

@implementation HLPresentTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:NO completion:nil];
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

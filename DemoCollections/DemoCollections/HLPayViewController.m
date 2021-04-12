//
//  HLPayViewController.m
//  DemoCollections
//
//  Created by 李白 on 2021/1/26.
//  Copyright © 2021 helong. All rights reserved.
//

#import "HLPayViewController.h"
#import "HLPaymentManger.h"
@interface HLPayViewController ()

@end

@implementation HLPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [HLPaymentManger singleton];
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

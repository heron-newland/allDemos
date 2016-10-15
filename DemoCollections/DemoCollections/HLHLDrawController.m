//
//  HLHLDrawController.m
//  DemoCollections
//
//  Created by helong on 2016/10/15.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLHLDrawController.h"
#import "HLDrawTextView.h"

@interface HLHLDrawController ()

@end

@implementation HLHLDrawController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    HLDrawTextView *drawText = [[HLDrawTextView alloc] initWithFrame:self.view.bounds];
    drawText.backgroundColor = [UIColor greenColor];
    [self.view addSubview:drawText];
    
    
    ///查看系统所有字体的方法
    NSLog(@"%@",[UIFont familyNames]);
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

//
//  HLSortMethodViewController.m
//  DemoCollections
//
//  Created by helong on 2016/10/16.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLSortMethodViewController.h"

@interface HLSortMethodViewController ()
//原始数组
@property (nonatomic, strong) NSArray *sourceArray;
@end

@implementation HLSortMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
   NSArray *res = [self insertSort];
    NSLog(@"%@",res);
}
#pragma mark - 插入排序
- (NSArray *)insertSort {
    
    NSMutableArray *sortedArray = [NSMutableArray array];
    
    [self.sourceArray sortedArrayUsingSelector:@selector(compare:)];
//    for (int i = 0; i<self.sourceArray.count;i++) {
//        if (i == 0) {
//            [sortedArray addObject:self.sourceArray[i]];
//        }else{
//            NSNumber *num = self.sourceArray[i];
//            for (int j = 0; j<sortedArray.count; j++) {
//                NSNumber *addedNum = sortedArray[j];
//                if (num.doubleValue > addedNum.doubleValue) {
//                    <#statements#>
//                }
//            }
//        }
//    }
    return [self.sourceArray sortedArrayUsingSelector:@selector(compare:)];;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 懒加载
- (NSArray *)sourceArray {
    if (!_sourceArray) {
        _sourceArray = @[@20,@30,@100,@60,@50];
    }
    return _sourceArray;
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

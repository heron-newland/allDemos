//
//  HLPolygonViewController.m
//  DemoCollections
//
//  Created by helong on 2016/10/31.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLPolygonViewController.h"
#import "HLPolygonAndRectView.h"

@interface HLPolygonViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet HLPolygonAndRectView *polygonView;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation HLPolygonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = @[@"Fill",@"EOFFill",@"Stroke",@"FillStroke",@"EOFFillStroke"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.dataSource.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.dataSource[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.polygonView.drawingMode = (CGPathDrawingMode)[pickerView selectedRowInComponent:component];
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

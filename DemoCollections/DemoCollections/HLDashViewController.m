//
//  HLDashViewController.m
//  DemoCollections
//
//  Created by helong on 2016/10/30.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLDashViewController.h"
#import "HLQuartzLineView.h"
@interface HLDashViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) IBOutlet HLQuartzDashView *dashView;

@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation HLDashViewController

//typedef struct {
//    CGFloat pattern[5];
//    size_t count;
//}Pattern;

static Pattern pattern[] = {
    {{10.0, 10.0}, 2},
    {{10.0, 20.0, 10.0}, 3},
    {{10.0, 20.0, 30.0}, 3},
    {{10.0, 20.0, 10.0, 30.0}, 4},
    {{10.0, 10.0, 20.0, 20.0}, 4},
    {{10.0, 10.0, 20.0, 30.0, 50.0}, 5},
};
static size_t patternCount = sizeof(pattern)/sizeof(pattern[0]);


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (IBAction)phase:(UISlider *)sender {
    self.dashView.phase = sender.value;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - picker Delegate and DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return patternCount;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    Pattern tmp_pattern = pattern[row];
    NSMutableString *str = [NSMutableString stringWithFormat:@"%.0f",tmp_pattern.pattern[0]];
    for (int i = 1; i<tmp_pattern.count; i++) {
        [str appendFormat:@"-%.0f",tmp_pattern.pattern[i]];
    }
    return str;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
     Pattern tmp_pattern = pattern[row];
    self.dashView.pattern = tmp_pattern;
//    for (int i = 0 ; i<tmp_pattern.count; i++) {
//        
//        
//    }
    
    
}
- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[@"",];
    }


    return _dataSource;
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

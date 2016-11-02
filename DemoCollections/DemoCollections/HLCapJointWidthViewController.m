//
//  HLCapJointWidthViewController.m
//  DemoCollections
//
//  Created by helong on 2016/10/30.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLCapJointWidthViewController.h"
#import "HLQuartzLineView.h"

@interface HLCapJointWidthViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *capSwitch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *joinSwitch;
@property (weak, nonatomic) IBOutlet UISlider *widthSlider;
@property (weak, nonatomic) IBOutlet UISlider *colorSlider;
@property (weak, nonatomic) IBOutlet HLQuartzCapJointWidth *capJoinWidthView;

@end

@implementation HLCapJointWidthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.capJoinWidthView.lineCap = (CGLineCap)self.capSwitch.selectedSegmentIndex;
    self.capJoinWidthView.lineJoin = (CGLineJoin)self.joinSwitch.selectedSegmentIndex;
    self.capJoinWidthView.lineWidth = self.widthSlider.value;
    self.capJoinWidthView.lineColor = [UIColor colorWithRed:self.colorSlider.value green:1-self.colorSlider.value  blue:self.colorSlider.value  alpha:1];
    
}
- (IBAction)capSegment:(UISegmentedControl *)sender {
 self.capJoinWidthView.lineCap = (CGLineCap)sender.selectedSegmentIndex;
}
- (IBAction)joinSegment:(UISegmentedControl *)sender {
    self.capJoinWidthView.lineJoin = (CGLineJoin)sender.selectedSegmentIndex;
}
- (IBAction)lineWidth:(UISlider *)sender {
    self.capJoinWidthView.lineWidth = sender.value;
}


//- (IBAction)widthSlider:(UISlider *)sender {
//    self.capJoinWidthView.lineWidth = self.widthSlider.value;
//}
//- (IBAction)colorSlider:(UISlider *)sender {
//     self.capJoinWidthView.lineColor = [UIColor colorWithRed:self.colorSlider.value * 0.4 green:1-self.colorSlider.value * 0.2  blue:self.colorSlider.value * 0.8  alpha:1];
//}

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

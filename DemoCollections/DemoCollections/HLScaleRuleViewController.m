//
//  HLScaleRuleViewController.m
//  DemoCollections
//
//  Created by 李白 on 2021/4/8.
//  Copyright © 2021 helong. All rights reserved.
//

#import "HLScaleRuleViewController.h"
#import "HLScaleRuleView.h"
@interface HLScaleRuleViewController (){
    CGFloat _scale;
}
@property(nonatomic,weak)HLScaleRuleView *scaleView;
@property(nonatomic,weak)UIView *tView;
@end

@implementation HLScaleRuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    HLScaleRuleView *v = [[HLScaleRuleView alloc] initWithFrame:CGRectZero];
    v.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:v];
    self.scaleView = v;
    
    
    UIView *tv = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 200, 200)];
    [self.view addSubview:tv];
    tv.backgroundColor = [UIColor redColor];
    self.tView = tv;
    
    UIPinchGestureRecognizer *pin = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinAction:)];
    [self.tView addGestureRecognizer:pin];
    
    
}

    -(void)pinAction:(UIPinchGestureRecognizer *)gesture {
        CGFloat scale;
        switch (gesture.state) {
            case UIGestureRecognizerStateEnded:
                //手势结束的时候将scale设置为1, 否则下次开始的时候回缩放很多
                _scale = 1;
                break;
            case UIGestureRecognizerStateChanged:
                scale = 1.0 - (_scale - [gesture scale]);
                self.tView.transform = CGAffineTransformScale(self.tView.transform, scale, scale);
                //设置新的scale,防止缩放增量成倍增加
                _scale = [gesture scale];
                break;
            default:
                break;
        }
        
        self.scaleView.scaleFactor = self.tView.frame.size.width / 200.0;
        NSLog(@"=======%lf",self.tView.frame.size.width / 200.0);
        NSLog(@"%@",self.tView);
    }


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.scaleView.frame = self.view.safeAreaLayoutGuide.layoutFrame;
}
@end

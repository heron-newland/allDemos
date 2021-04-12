//
//  HLQuartzTextViewController.m
//  DemoCollections
//
//  Created by 李白 on 2021/4/7.
//  Copyright © 2021 helong. All rights reserved.
//

#import "HLQuartzTextViewController.h"
#import "HLQuartzTextView.h"
@interface HLQuartzTextViewController (){
    CGFloat _scale;
}
@property(nonatomic,weak)HLQuartzTextView *tView;
@end

@implementation HLQuartzTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    HLQuartzTextView *v = [[HLQuartzTextView alloc] initWithFrame:CGRectMake(0, 100, 200, 300)];
    v.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:v];
    self.tView = v;
    UIPinchGestureRecognizer *pin = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinAction:)];
    [v addGestureRecognizer:pin];
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

//
//  HLStatusBarViewController.m
//  DemoCollections
//
//  Created by 李白 on 2021/2/24.
//  Copyright © 2021 helong. All rights reserved.
//

#import "HLStatusBarViewController.h"

@interface HLStatusBarViewController ()
@property(nonatomic,strong)UIWindow *overWindow;
@end

@implementation HLStatusBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, -20, 300, 400)];
    [self.view addSubview:imgV];
    imgV.image = [UIImage imageNamed:@"4668682381_hq720"];
    imgV.userInteractionEnabled = true;
    self.view.backgroundColor = [UIColor lightGrayColor];
  
}
- (BOOL)prefersStatusBarHidden {
    return true;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
      self.overWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, [UIApplication sharedApplication].statusBarFrame.size.height, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height - [UIApplication sharedApplication].statusBarFrame.size.height)];
            self.overWindow.tag = 12315;

    HLStatusBarViewController *vc = [[HLStatusBarViewController alloc] init];
//    vc.modalPresentationStyle = UIModalPresentationFullScreen;
//    [self presentViewController:vc animated:true completion:nil];
            self.overWindow.backgroundColor = [UIColor whiteColor];
            self.overWindow.rootViewController = vc;
            self.overWindow.hidden = false;
            //    self.overWindow.alpha = 1;
            self.overWindow .windowLevel = UIWindowLevelStatusBar - 1;
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

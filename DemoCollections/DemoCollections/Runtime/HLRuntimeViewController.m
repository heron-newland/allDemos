//
//  HLRuntimeViewController.m
//  DemoCollections
//
//  Created by 李白 on 2021/3/11.
//  Copyright © 2021 helong. All rights reserved.
//

#import "HLRuntimeViewController.h"
#import <WebKit/WebKit.h>
@interface HLRuntimeViewController ()

@end

@implementation HLRuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    WKWebView *web = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    [UIApplication.sharedApplication.keyWindow addSubview:web];
       [[self getCurrentViewController].view addSubview:web];
//    [self.view addSubview:web];
      [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.120.217"]]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (UIViewController *)getCurrentViewController{
    UIViewController* currentViewController = UIApplication.sharedApplication.keyWindow.rootViewController;
    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            currentViewController = currentViewController.presentedViewController;
        } else if ([currentViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController* navigationController = (UINavigationController* )currentViewController;
            currentViewController = [navigationController.childViewControllers lastObject];
            
        } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController* tabBarController = (UITabBarController* )currentViewController;
            currentViewController = tabBarController.selectedViewController;
        } else {
            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if (childViewControllerCount > 0) {
                
                currentViewController = currentViewController.childViewControllers.lastObject;
                
                return currentViewController;
            } else {
                
                return currentViewController;
            }
        }
    }
    return currentViewController;
}

@end

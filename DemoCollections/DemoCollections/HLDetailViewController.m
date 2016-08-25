//
//  HLDetailViewController.m
//  DemoCollections
//
//  Created by helong on 16/8/25.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLDetailViewController.h"

@interface HLDetailViewController ()

@end

@implementation HLDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"知识要点";
    // Do any additional setup after loading the view.
    //  将webView添加到view上
    UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:web];
    //  没有此句webview会有黑条
    web.opaque = NO;
    web.backgroundColor = [UIColor whiteColor];
    
    
    // 使用webView加载本地html的方法
    //  找到资源路径
    NSString *path = [[NSBundle mainBundle] pathForResource:self.detailInfos ofType:nil];
    //  根据资源路径加载字符串
    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //  获取baseURL
    NSString *basePath = [[NSBundle mainBundle] bundlePath];
    NSURL *baseURL = [NSURL fileURLWithPath:basePath];
    //  加载html字符串
    [web loadHTMLString:htmlString baseURL:baseURL];
    

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

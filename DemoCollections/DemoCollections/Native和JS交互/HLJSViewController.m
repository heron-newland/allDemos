//
//  HLJSViewController.m
//  DemoCollections
//
//  Created by 李白 on 2021/1/26.
//  Copyright © 2021 helong. All rights reserved.
//

#import "HLJSViewController.h"
#import <WebKit/WebKit.h>
@interface HLJSViewController ()<WKUIDelegate, WKNavigationDelegate,WKScriptMessageHandler>
@property(nonatomic,strong)WKWebView *webView;
@end


/// H5调用原生
static NSString *kSendLoginInfo = @"sendLoginInfo";//发送登录信息给原生

static NSString *kGetUserInfo = @"getUserInfo";//从原生获取用户信息

static NSString *kGetDeviceInfo = @"getDeviceInfo";//从原生获取设备信息

static NSString *kGetNodeInfo = @"getNodeInfo";//从原生获取线路信息

static NSString *kSendCurrentOrder = @"sendCurrentOrder";//发送订单信息给原生

static NSString *kGetBaseApi = @"getBaseApi";//从原生获取API的域名

static NSString *kGetWebsite = @"getWebsite";//从原生获取官网域名

static NSString *kSendOpenUrl = @"sendOpenUrl";//发送链接给原生打开

static NSString *kSendOpenPage = @"sendOpenPage";//发送页面给原生打开

static NSString *kSendSavePicture = @"sendSavePicture";//发送图片给原生保存

static NSString *kSendClosePage = @"sendClosePage";//发送关闭页面给原生, 原生必须调用notifyClosePage回调给H5

static NSString *kSendErrorLog = @"sendErrorLog";//发送错误日志给原生


///原生调用H5
static NSString *kCurrentUserChange = @"currentUserChange";//原生主动推送用户信息

static NSString *kCurrentLineChange = @"currentLineChange";//原生主动推送线路信息

static NSString *kNotifyUserLogout = @"notifyUserLogout";//通知H5页面用户退出

static NSString *kNotifyUserScanLogin = @"notifyUserScanLogin";//通知H5扫码登录确认

static NSString *kNotifyClosePage = @"notifyClosePage";//页面关闭回调

static NSString *kNotifyBackPressed = @"notifyBackPressed";//通知H5页面返回上一页

static NSString *kNotifyRouterLink = @"notifyRouterLink";//通知H5页面跳转

static NSString *kSendUnreadMessage = @"sendUnreadMessage";//通知H5有未读消息



@implementation HLJSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    
    //注册函数给H5调用
    [config.userContentController addScriptMessageHandler:self name:kSendLoginInfo];
    [config.userContentController addScriptMessageHandler:self name:kGetUserInfo];
    [config.userContentController addScriptMessageHandler:self name:kGetDeviceInfo];
    [config.userContentController addScriptMessageHandler:self name:kGetNodeInfo];
    [config.userContentController addScriptMessageHandler:self name:kSendCurrentOrder];
    [config.userContentController addScriptMessageHandler:self name:kGetBaseApi];
    [config.userContentController addScriptMessageHandler:self name:kGetWebsite];
    [config.userContentController addScriptMessageHandler:self name:kSendOpenUrl];
    [config.userContentController addScriptMessageHandler:self name:kSendOpenPage];
    [config.userContentController addScriptMessageHandler:self name:kSendSavePicture];
    [config.userContentController addScriptMessageHandler:self name:kSendClosePage];
    [config.userContentController addScriptMessageHandler:self name:kSendErrorLog];

    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    self.webView.allowsBackForwardNavigationGestures = true;
    [self.view addSubview:self.webView];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.120.216/testJs/test.html"]]];
}


- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    //无法执行脚本
//    [self.webView evaluateJavaScript:@"calledByNative(\"1\");" completionHandler:^(id _Nullable data, NSError * _Nullable error) {
//              NSLog(@"%@执行脚本报错:%@",data,error);
//          }];
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    //无法执行脚本
//    [self.webView evaluateJavaScript:@"calledByNative(\"4\");" completionHandler:^(id _Nullable data, NSError * _Nullable error) {
//              NSLog(@"%@执行脚本报错:%@",data,error);
//          }];
    decisionHandler(WKNavigationResponsePolicyAllow);
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
     //无法执行脚本
//    [self.webView evaluateJavaScript:@"calledByNative(\"5\");" completionHandler:^(id _Nullable data, NSError * _Nullable error) {
//              NSLog(@"%@执行脚本报错:%@",data,error);
//          }];
}


- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    //最早能执行脚本成功的地方,前面的回调执行脚本都会报错
    [self.webView evaluateJavaScript:@"calledByNative(\"calledByNative\");" completionHandler:^(id _Nullable data, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@执行脚本报错:%@",data,error);
            
        }
    }];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    //此处执行脚本最为稳妥,但是时机比didCommitNavigation稍晚
//[self.webView evaluateJavaScript:@"calledByNative(\"2\",\"calledByNativeCallback\");" completionHandler:^(id _Nullable data, NSError * _Nullable error) {
//          NSLog(@"%@执行脚本报错:%@",data,error);
//      }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {

    if ([message.name isEqualToString:kSendLoginInfo]) {
        
    }else if ([message.name isEqualToString:kGetUserInfo]) {
        
    }else if ([message.name isEqualToString:kGetDeviceInfo]) {
        
    }else if ([message.name isEqualToString:kGetNodeInfo]) {
        
    }else if ([message.name isEqualToString:kSendCurrentOrder]) {
        
    }else if ([message.name isEqualToString:kGetBaseApi]) {
        
    }else if ([message.name isEqualToString:kGetWebsite]) {
        
    }else if ([message.name isEqualToString:kSendOpenUrl]) {
        
    }else if ([message.name isEqualToString:kSendOpenPage]) {
        
    }else if ([message.name isEqualToString:kSendSavePicture]) {
        
    }else if ([message.name isEqualToString:kSendClosePage]) {
        
    }else if ([message.name isEqualToString:kSendErrorLog]) {
        
    }
 
    
    NSLog(@"%@++%@++%@",message.name, message.body,message.frameInfo);
}


- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    NSLog(@"弹窗:%@",message);
    completionHandler();
}

/// 执行js
/// @param name js名称
/// @param param 参数
- (void)evaluateJsWithFuncName:(NSString *)name param:(NSDictionary *)param {
   
}

@end

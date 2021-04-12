//
//  HLPaymentManger.m
//  DemoCollections
//
//  Created by 李白 on 2021/1/26.
//  Copyright © 2021 helong. All rights reserved.
//

#import "HLPaymentManger.h"
#import <StoreKit/StoreKit.h>

@interface HLPaymentManger()<SKPaymentTransactionObserver,SKProductsRequestDelegate>
@property(nonatomic,strong)NSString *currentProductId;
@property(nonatomic,strong)NSString *orderId;
@property(nonatomic,copy)void(^payResultCompletion)(NSDictionary *payResults);
@end
@implementation HLPaymentManger

+ (instancetype)singleton {
    static HLPaymentManger *singleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[HLPaymentManger alloc] init];
    });
    return singleton;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //添加监听
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        //TODO: - 开始上次没有完成的内购
        [self makePurchaseWithProductID:@"1234"];
    }
    return self;
}

#pragma mark - 内购请求
- (void)makePurchaseWithProductID:(NSString *)productID {
    [self makePurchaseWithProductID:productID completion:nil];
}
/// 开始购买
- (void)makePurchaseWithProductID:(NSString *)productID completion:(void(^)(NSDictionary *payResults))completion {
      self.payResultCompletion = completion;
    if (!productID) {
        NSLog(@"产品ID为空");
        return;
    }
    self.currentProductId = productID;
    //检测是否允许内购
    if ([SKPaymentQueue canMakePayments]){
        NSSet *productSet = [NSSet setWithArray:@[productID]];
        SKProductsRequest *productRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productSet];
        productRequest.delegate = self;
        [productRequest start];
    } else {
    //已禁止内购
        NSLog(@"已禁止内购.进入“【设置】 - 开启【屏幕使用时间】功能。然后在【屏幕使用时间】选项中选择【内容和隐私访问限制】，选择【iTunes Store 与 App store 购买】- 选择【App内购项目】- 选择“允许”，将该功能开启");
    }
}

#pragma mark - SKProductsRequestDelegate
// Sent immediately before -requestDidFinish:
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSLog(@"请求收到响应:%@",response.invalidProductIdentifiers);
    SKProduct *requestProduct = nil;
    for (SKProduct *product in response.products) {
        if([product.productIdentifier isEqualToString:self.currentProductId]) {
            requestProduct = product;
        }
    }
    if (requestProduct) {
        NSLog(@"开始下单");
        SKPayment *payment = [SKPayment paymentWithProduct:requestProduct];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    } else {
         NSLog(@"没有查询到相应的产品信息");
    }
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"请求动作失败:%@",error);
}

- (void)requestDidFinish:(SKRequest *)request {
    NSLog(@"请求动作完成:%@",request);
}

#pragma mark -
#pragma mark - 监听用户支付交易变化
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState){
            case SKPaymentTransactionStatePurchased://交易完成
                [self verifyReceiptByTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed://交易失败
                [self failTransation:transaction];
                break;
            case SKPaymentTransactionStateRestored://已经购买过该商品
                [self verifyReceiptByTransaction:transaction];
                break;
            case SKPaymentTransactionStatePurchasing:      //商品添加进列表
                //解决applicationUsername支付一半kill进程后为nil的问题
                [self saveCurrTransationBindedOrderId];
                break;
            default:
                break;
        }
    }
}

// Sent when transactions are removed from the queue (via finishTransaction:).
- (void)paymentQueue:(SKPaymentQueue *)queue removedTransactions:(NSArray<SKPaymentTransaction *> *)transactions API_AVAILABLE(ios(3.0), macos(10.7), watchos(6.2)) {
    NSLog(@"removedTransactions");
}

// Sent when an error is encountered while adding transactions from the user's purchase history back to the queue.
- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error API_AVAILABLE(ios(3.0), macos(10.7), watchos(6.2)) {
     NSLog(@"restoreCompletedTransactionsFailedWithError");
}

// Sent when all transactions from the user's purchase history have successfully been added back to the queue.
- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue API_AVAILABLE(ios(3.0), macos(10.7), watchos(6.2)) {
    NSLog(@"restoreCompletedTransactionsFailedWithError");
}

// Sent when the download state has changed.
- (void)paymentQueue:(SKPaymentQueue *)queue updatedDownloads:(NSArray<SKDownload *> *)downloads API_AVAILABLE(ios(6.0), macos(10.8), watchos(6.2)) {
    NSLog(@"updatedDownloads");
}

// Sent when a user initiates an IAP buy from the App Store
//- (BOOL)paymentQueue:(SKPaymentQueue *)queue shouldAddStorePayment:(SKPayment *)payment forProduct:(SKProduct *)product NS_SWIFT_NAME(paymentQueue(_:shouldAddStorePayment:for:)) API_AVAILABLE(ios(11.0)) API_UNAVAILABLE(macos, macCatalyst, watchos){
//    NSLog(@"shouldAddStorePayment");
//    return true;
//}

- (void)paymentQueueDidChangeStorefront:(SKPaymentQueue *)queue API_AVAILABLE(ios(13.0), macos(10.15), watchos(6.2)){
    NSLog(@"paymentQueueDidChangeStorefront");
}


//交易失败
- (void)failTransation:(SKPaymentTransaction *)transaction {
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    IAPurchaseStatus status = IAPurchaseFailed;
    if (transaction.error.code != SKErrorPaymentCancelled) {
        status = IAPurchaseCancel;
    }
    if (self.IAPurchaseResult) {
        self.IAPurchaseResult(status);
    }
}

//持久化当前正在交易绑定的业务订单
- (void)saveCurrTransationBindedOrderId {
    NSLog(@"商品添加进列表");
    if (self.orderId) {
        NSDictionary *orderdic = @{@"productId":self.currentProductId,
                                   @"orderId": self.orderId
                                   };
        [[NSUserDefaults standardUserDefaults] setObject:orderdic forKey:@"persient.IAP.order"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (NSString *)bindedOrderId {
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"persient.IAP.order"];
    if (dic) {
        return dic[@"orderId"];
    }else {
        return nil;
    }
}


//验证票据
- (void)verifyReceiptByTransaction:(SKPaymentTransaction *)transaction {
    NSString *receiptString = [self iapReceipt];
    if (!receiptString) {
        if (self.IAPurchaseResult) {
            self.IAPurchaseResult(IAPurchaseVerifyReciptFailed);
        }
        return;
    }
    NSError *error;
    NSDictionary *requestContents = @{@"receipt-data": receiptString};
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestContents
                                                          options:0
                                                            error:&error];
    
    if (!requestData) { // 交易凭证为空验证失败
        if (self.IAPurchaseResult) {
            self.IAPurchaseResult(IAPurchaseVerifyReciptFailed);
        }
        return;
    }
    //向苹果服务器验证支付凭据真实性
    [self verifyRequestData:requestData testSandbox:NO transaction:transaction];
}

//获取内购票据
- (NSString *)iapReceipt {
    NSString *receiptString = nil;
    NSURL *rereceiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    NSData *receipt = [NSData dataWithContentsOfURL:rereceiptURL];
    receiptString = [receipt base64EncodedStringWithOptions:0];
    return receiptString;
}

- (void)verifyRequestData:(NSData *)postData testSandbox:(BOOL)test transaction:(SKPaymentTransaction *)transaction {
    NSString *url = @"https://buy.itunes.apple.com/verifyReceipt";
    if (test) {
        url = @"https://sandbox.itunes.apple.com/verifyReceipt";
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.HTTPBody = postData;
    static NSString *requestMethod = @"POST";
    request.HTTPMethod = requestMethod;

    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"购买失败:%@",error);
            return;
        }
        NSError *jsonError = nil;
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        if (!jsonResponse) {
            // 苹果服务器校验数据返回为空校验失败
            if (self.IAPurchaseResult) {
                self.IAPurchaseResult(IAPurchaseVerifyReciptFailed);
            }
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            return ;
        }
        
        //先验证正式服务器,如果正式服务器返回21007再去苹果测试服务器验证,沙盒测试环境苹果用的是测试服务器
        NSString *status = [NSString stringWithFormat:@"%@", jsonResponse[@"status"]];
        if (status && [status isEqualToString:@"21007"]) {
            [self verifyRequestData:postData testSandbox:YES transaction:transaction];
        } else if (status && [status isEqualToString:@"0"]) {
            //订单校验成功
            NSString *orderId = transaction.payment.applicationUsername;
            if (!orderId) {
                orderId = [self bindedOrderId];
            }
            NSLog(@"苹果服务器返回充值成功的逻辑, 此处需要再次向后台查询确认支付结果");
            
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
        }else {
            // 苹果服务器校验数据返回为空校验失败
            if (self.IAPurchaseResult) {
                self.IAPurchaseResult(IAPurchaseVerifyReciptFailed);
            }
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
        }
    }] resume];
}

@end


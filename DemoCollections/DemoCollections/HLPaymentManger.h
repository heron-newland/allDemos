//
//  HLPaymentManger.h
//  DemoCollections
//
//  Created by 李白 on 2021/1/26.
//  Copyright © 2021 helong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, IAPurchaseStatus) {
    IAPurchaseSucceed,
    IAPurchaseCancel,
    IAPurchaseFailed,
    IAPurchaseVerifyReciptFailed,
};

@interface HLPaymentManger : NSObject
@property(nonatomic,copy)void(^IAPurchaseResult)(NSInteger);
+ (instancetype)singleton;


/// 购买
/// @param productID 产品id
/// @param orderId 订单号
- (void)makePurchaseWithProductID:(NSString *)productID;

/// 购买
/// @param productID 产品id
/// @param orderId 订单号
/// @param completion
- (void)makePurchaseWithProductID:(NSString *)productID
                       completion:(void(^)(NSDictionary *payResults))completion;

@end



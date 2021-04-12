//
//  UIViewController+HLExchange.m
//  DemoCollections
//
//  Created by 李白 on 2021/3/30.
//  Copyright © 2021 helong. All rights reserved.
//

#import "UIViewController+HLExchange.h"
#import <objc/runtime.h>
@implementation UIViewController (HLExchange)
+(void)load {
    SEL originSel = @selector(viewDidLoad);
    SEL changeSel = @selector(hl_viewDidLoad);
    IMP originImp = class_getMethodImplementation([self class], originSel);
     IMP changeImp = class_getMethodImplementation([self class], changeSel);
    
   BOOL res = class_addMethod([self class], originSel, originImp, "v@:");
    if (res) {
        class_replaceMethod([self class], originSel, changeImp, "v@:");
    }else{
        method_exchangeImplementations(class_getInstanceMethod([self class], originSel), class_getInstanceMethod([self class], changeSel));
    }
}

- (void)hl_viewDidLoad {
     NSLog(@"2");
    [self hl_viewDidLoad];
     NSLog(@"3");
}

@end

//
//  HLLockStatus.m
//  DemoCollections
//
//  Created by 李白 on 2021/3/8.
//  Copyright © 2021 helong. All rights reserved.
//

#import "HLLockStatus.h"
#import <notify.h>



void setScreenStateCb() {
    uint64_t locked;
    __block int token = 0;
    notify_register_dispatch("com.apple.springboard.lockstate",&token,dispatch_get_main_queue(),^(int t){
    });
    notify_get_state(token, &locked);
    NSLog(@"%d",(int)locked);
}


void screenLockStateChanged(CFNotificationCenterRef center,void* observer,CFStringRef name,const void* object,CFDictionaryRef userInfo){
    NSString* lockstate = (__bridge NSString*)name;
    if ([lockstate isEqualToString:(__bridge NSString*)NotificationLock]) {
        // 锁屏
        NSLog(@"locked.");
    } else {
        NSLog(@"lock state changed.");
    }
}

@implementation HLLockStatus

+ (instancetype)singleton {
    static HLLockStatus *singleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[HLLockStatus alloc] init];
    });
    return singleton;
}
-(BOOL)didUserPressLockButton{
    //获取屏幕亮度
    CGFloat oldBrightness = [UIScreen mainScreen].brightness;
    //以较小的数量改变屏幕亮度
    [UIScreen mainScreen].brightness = oldBrightness + (oldBrightness <= 0.01 ? (0.01) : (-0.01));
    CGFloat newBrightness  = [UIScreen mainScreen].brightness;
    //恢复屏幕亮度
    [UIScreen mainScreen].brightness = oldBrightness;
    //判断屏幕亮度是否能够被改变
    return oldBrightness != newBrightness;
}

@end

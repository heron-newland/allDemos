//
//  HLLockStatus.h
//  DemoCollections
//
//  Created by 李白 on 2021/3/8.
//  Copyright © 2021 helong. All rights reserved.
//

#import <Foundation/Foundation.h>
#define NotificationLock CFSTR("com.apple.springboard.lockcomplete")
#define NotificationChange CFSTR("com.apple.springboard.lockstate")
#define NotificationPwdUI CFSTR("com.apple.springboard.hasBlankedScreen")


void setScreenStateCb();
void screenLockStateChanged(CFNotificationCenterRef center,void* observer,CFStringRef name,const void* object,CFDictionaryRef userInfo);
NS_ASSUME_NONNULL_BEGIN

@interface HLLockStatus : NSObject
+ (instancetype)singleton;
-(BOOL)didUserPressLockButton;
@end

NS_ASSUME_NONNULL_END

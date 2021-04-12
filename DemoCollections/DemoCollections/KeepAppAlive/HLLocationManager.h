//
//  HLLocationManager.h
//  DemoCollections
//
//  Created by 李白 on 2021/3/9.
//  Copyright © 2021 helong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HLLocationManager : NSObject
+ (instancetype)singleton;
- (void)start;
- (void)stop;
- (void)requestAuthority;
@end


NS_ASSUME_NONNULL_END

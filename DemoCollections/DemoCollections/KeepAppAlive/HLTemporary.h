//
//  HLTemporary.h
//  DemoCollections
//
//  Created by 李白 on 2021/3/9.
//  Copyright © 2021 helong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HLTemporary : NSObject
+ (instancetype)singleton;
@property(nonatomic,assign)BOOL available;
@end

NS_ASSUME_NONNULL_END

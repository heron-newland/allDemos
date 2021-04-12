//
//  HLTemporary.m
//  DemoCollections
//
//  Created by 李白 on 2021/3/9.
//  Copyright © 2021 helong. All rights reserved.
//

#import "HLTemporary.h"

@implementation HLTemporary
+ (instancetype)singleton {
    static HLTemporary *singleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[HLTemporary alloc] init];
    });
    return singleton;
}
@end

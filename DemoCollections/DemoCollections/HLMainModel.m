//
//  HLMainModel.m
//  DemoCollections
//
//  Created by helong on 16/8/25.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLMainModel.h"

@implementation HLMainModel

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+ (instancetype)mainModelWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}
@end

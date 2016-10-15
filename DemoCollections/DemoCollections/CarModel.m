//
//  CZCarModel.m
//  06.汽车数据展示_嵌套模型
//
//  Created by whitcast on 16/4/27.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CarModel.h"

@implementation CarModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.icon = dict[@"icon"];
        self.name = dict[@"name"];
    }
    return self;
}
+ (instancetype)carWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}
@end

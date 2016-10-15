//
//  CZCarSectionModel.m
//  06.汽车数据展示_嵌套模型
//
//  Created by whitcast on 16/4/27.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import "CarSectionModel.h"

@implementation CarSectionModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.cars = dict[@"cars"];
        self.title = dict[@"title"];
    }
    return self;
}
+ (instancetype)carSectionWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}
@end

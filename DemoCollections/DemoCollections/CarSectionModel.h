//
//  CZCarSectionModel.h
//  06.汽车数据展示_嵌套模型
//
//  Created by whitcast on 16/4/27.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarSectionModel : NSObject
// 一组汽车
@property(strong,nonatomic) NSArray *cars;

// 分组的名字
@property(copy,nonatomic) NSString *title;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)carSectionWithDict:(NSDictionary *)dict;
@end

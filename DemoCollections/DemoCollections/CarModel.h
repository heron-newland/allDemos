//
//  CZCarModel.h
//  06.汽车数据展示_嵌套模型
//
//  Created by whitcast on 16/4/27.
//  Copyright © 2016年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarModel : NSObject
// 图片名
@property(copy,nonatomic) NSString *icon;
// 汽车名
@property(copy,nonatomic) NSString *name;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)carWithDict:(NSDictionary *)dict;
@end

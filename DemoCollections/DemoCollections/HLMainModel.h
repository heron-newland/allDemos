//
//  HLMainModel.h
//  DemoCollections
//
//  Created by helong on 16/8/25.
//  Copyright © 2016年 helong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLMainModel : NSObject
//  标题
@property (nonatomic, strong) NSString *title;
//  目标控制器
@property (nonatomic, strong) NSString *targetVC;
//  知识详情
@property (nonatomic, strong) NSString *detailInfos;

//  字典转模型
- (instancetype)initWithDictionary:(NSDictionary *)dict;
+ (instancetype)mainModelWithDictionary: (NSDictionary *)dict;
@end

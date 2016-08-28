//
//  HLDataBaseTool.h
//  DemoCollections
//
//  Created by helong on 16/8/28.
//  Copyright © 2016年 helong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HLStudentModel;
@interface HLDataBaseManager : NSObject

/**
 *  插入数据
 */
+ (void)insertObject:(HLStudentModel *)student;
//+ (void)insertOperation:(NSString *)sqliteString Object: (HLStudentModel *)student;
/**
 *  删除数据
 */
+ (void)deleteOperation:(NSString *)sqliteString;
/**
 *  更新数据
 */
+ (void)updataOperation:(NSString *)sqliteString;
/**
 *  查询数据
 */
+ (NSArray *)queryOperation:(NSString *)sqliteString Page:(NSInteger)page ;
@end

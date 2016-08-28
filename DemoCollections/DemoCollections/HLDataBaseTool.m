//
//  HLDataBaseTool.m
//  DemoCollections
//
//  Created by helong on 16/8/28.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLDataBaseTool.h"
#import "HLStudentModel.h"

@interface HLDataBaseManager()


@end


@implementation HLDataBaseManager

FMDatabase *_db;
/**
 *  创建数据库
 */
+ (void)initialize {
    //  指定数据库创建的路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
   NSString *dataPath = [path stringByAppendingPathComponent:@"data.sqlite"];
    
   _db = [FMDatabase databaseWithPath:dataPath];
    
    if ([_db open]) {
        //  创建数据库成功, 接下来创建数据表
        NSLog(@"success");
        
       BOOL result = [_db executeUpdate:@"create table if not exists t_student(studentNO integer primary key,name text not null,address text,age integer not null default 1);"];
        if (result) {
            NSLog(@"create table success");
        }
    }else {
        NSLog(@"failed");
    }
    
}
#pragma mark - 插入数据
//+ (void)insertOperation:(NSString *)sqliteString Object:(HLStudentModel *)student {
//    BOOL res = [_db executeUpdate:sqliteString];
//    if (res) {
//        NSLog(@"insert success");
//    }
//}

+ (void)insertObject: (HLStudentModel *)student {
    
   BOOL res = [_db executeUpdateWithFormat:@"insert into t_student(name, age) values(%@, %ld)",student.name, student.age];
    if (res) {
        NSLog(@"insert success");
    }
}

+ (void)deleteOperation:(NSString *)sqliteString {
    BOOL res = [_db executeUpdate:sqliteString];
    if (res) {
        NSLog(@"delete success");
    }
}
//+ (void)deleteObject{
//    BOOL res = [_db executeUpdateWithFormat:@"delete from t_student where age <= 30"];
//    if (res) {
//        NSLog(@"insert success");
//    }
//}

+ (void)updataOperation:(NSString *)sqliteString {
    BOOL res = [_db executeUpdate:sqliteString];
    if (res) {
        NSLog(@"update success");
    }
}
//+ (void)updataObject {
//    BOOL res = [_db executeUpdateWithFormat:@"update t_student set name = 'Lucy' where age < 30"];
//    if (res) {
//        NSLog(@"insert success");
//    }
//}

+ (NSArray *)queryOperation:(NSString *)sqliteString Page:(NSInteger)page {
    NSMutableArray *tempArr = [NSMutableArray array];
    
    FMResultSet *result = [_db executeQuery:sqliteString];
    while ([result next]) {
        NSString *name = [result stringForColumn:@"name"];
        NSInteger age = [result intForColumn:@"age"];
        HLStudentModel *model = [[HLStudentModel alloc] init];
        model.name = name;
        model.age = age;
        [tempArr addObject:model];
    }
    return tempArr.copy;
}
//+ (NSArray *)queryPage:(NSInteger)page {
//    NSMutableArray *tempArr = [NSMutableArray array];
//
//    FMResultSet *result = [_db executeQueryWithFormat:@"select * from t_student order by age limit %ld, 5",page * 5];
//    while ([result next]) {
//        NSString *name = [result stringForColumn:@"name"];
//        NSInteger age = [result intForColumn:@"age"];
//       HLStudentModel *model = [[HLStudentModel alloc] init];
//        model.name = name;
//        model.age = age;
//        [tempArr addObject:model];
//    }
//    return tempArr.copy;
//}
@end

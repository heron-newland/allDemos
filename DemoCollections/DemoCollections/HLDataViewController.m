//
//  HLDataViewController.m
//  DemoCollections
//
//  Created by helong on 16/8/28.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLDataViewController.h"
#import "HLStudentModel.h"

@interface HLDataViewController ()
@property (nonatomic, assign) NSInteger index;
@end
@implementation HLDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    HLDataBaseManager *manager1 = [[HLDataBaseManager alloc] init];
    
    NSLog(@"%p",manager1);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    HLStudentModel *student = [[HLStudentModel alloc] init];
    student.name = [NSString stringWithFormat:@"Jack%ld",self.index];
    student.age = arc4random_uniform(50)+1;

    //  插入语句
     NSString *insertString = [NSString stringWithFormat:@"insert into t_student(name, age) values(%@, %ld)",student.name, student.age];
    NSLog(@"%@",insertString);
    //  删除语句
    NSString *deleteString = [NSString stringWithFormat:@"delete from t_student where age <= 30"];
    //  更新语句
    NSString *updateString = [NSString stringWithFormat:@"update t_student set name = 'Lucy' where age < 50"];
    //  查询语句
    NSString *queryString = [NSString stringWithFormat:@"select * from t_student order by age limit %ld, 5",self.index * 5];
    
    //  增删该查的操作
    //    [HLDataBaseManager insertObject:student];
//    [HLDataBaseManager deleteOperation:deleteString];
//    [HLDataBaseManager updataOperation:updateString];
    NSArray *arr = [HLDataBaseManager queryOperation:queryString Page:self.index];
    for (HLStudentModel *model in arr) {
        
        NSLog(@"%@,%ld",model.name, model.age);
    }
    self.index++;
}
@end

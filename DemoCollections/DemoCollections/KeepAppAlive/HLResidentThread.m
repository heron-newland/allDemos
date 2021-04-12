//
//  HLResidentThread.m
//  DemoCollections
//
//  Created by 李白 on 2021/3/8.
//  Copyright © 2021 helong. All rights reserved.
//

#import "HLResidentThread.h"
@interface HLResidentThread()
@end

@implementation HLResidentThread{
    NSMutableArray *actions;
    NSThread *thread;
    dispatch_semaphore_t sem;
    bool cancel;
}
-(id)init{
    self = [super init];
    actions = [NSMutableArray array];
    // 创建信号量
    sem = dispatch_semaphore_create(0);
    // 创建一个新线程
    thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    [thread start];
    return self;
}

-(void)run{
    while (true) {
        // 等待信号量,信号量减1
        dispatch_semaphore_wait(sem, -1);
        // 收到信号
        // 如果线程已经取消了，那么退出循环
        if(cancel){
            break;
        }
        // 开始执行任务
        dispatch_block_t block = [actions firstObject];
        if(block){
            [actions removeObject:block];
            block();
        }
        
    }
}

// 执行某个任务
-(void)doAction:(dispatch_block_t)action{
    if(!cancel){ // 如果线程已经cancel了，那么直接忽略
        // 将任务放入数组
        [actions addObject:[action copy]];
        // 发送信号，信号量加1
        dispatch_semaphore_signal(sem);
    }
}

// 终止常驻线程
-(void)cancel{
    cancel = YES;
    // 线程取消后，清空所有的回调
    [actions removeAllObjects];
    // 相当于发送一个终止任务的信号
    dispatch_semaphore_signal(sem);
}
@end

//
//  HLAPIAttributeViewController.m
//  DemoCollections
//
//  Created by 李白 on 2021/2/3.
//  Copyright © 2021 helong. All rights reserved.
//

#import "HLAPIAttributeViewController.h"

@interface HLAPIAttributeViewController ()

@end

@implementation HLAPIAttributeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self deprecate1];
     [self deprecate2];
    [self deprecate3];
    [self deprecate5];
    [self deprecate4];
     [self deprecate6];
     [self deprecate7];
    
    [self test];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self test];
}
- (void)test {
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);

      dispatch_async(dispatch_get_global_queue(0, 0), ^{
          NSLog(@"任务1：%@",[NSThread currentThread]);
          // 发送信号量
          sleep(7);
          dispatch_semaphore_signal(sem);
      });

      // 等待信号量
      dispatch_semaphore_wait(sem, dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)));

    NSLog(@"1");
    
    
      dispatch_async(dispatch_get_global_queue(0, 0), ^{
          NSLog(@"任务2：%@",[NSThread currentThread]);
          // 发送信号量
          sleep(3);
          dispatch_semaphore_signal(sem);
      });
      // 等待信号量
      dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);

     NSLog(@"2");
      dispatch_async(dispatch_get_global_queue(0, 0), ^{
          NSLog(@"任务3：%@",[NSThread currentThread]);
      });
     NSLog(@"3");
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
//    dispatch_async(, ^{
//        sleep(4);
//        dispatch_semaphore_signal(semaphore);
//    });
//    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//    NSLog(@"1111");
}
//
- (void)deprecate1 NS_DEPRECATED_IOS(10.0, 12.0) {
    
}

- (void)deprecate2 DEPRECATED_MSG_ATTRIBUTE("已经过期啦") {
    
}

- (void)deprecate3 API_DEPRECATED_WITH_REPLACEMENT("initWithMemoryCapacity:diskCapacity:directoryURL:", macos(10.2,11.0), ios(2.0,10.0), watchos(2.0,API_TO_BE_DEPRECATED), tvos(9.0,10.0)) {
    
}


- (void)deprecate4 NS_AVAILABLE(10.10,14.0){
    
}

- (void)deprecate5 API_AVAILABLE(macos(10.10),ios(14.0)){
    
}

- (void)deprecate6 NS_AVAILABLE_IOS(14_0){
    
}
- (void)deprecate7 NS_DEPRECATED(9_0, 11_0, 7_0, 12_0){
    
}
@end

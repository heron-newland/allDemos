//
//  HLRACViewController.m
//  DemoCollections
//
//  Created by 李白 on 2021/3/11.
//  Copyright © 2021 helong. All rights reserved.
//

#import "HLRACViewController.h"
#import <objc/runtime.h>
#import <objc/message.h>
@interface HLRACViewController ()

@end

@implementation HLRACViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self performSelector:@selector(abc)];
//    NSLog(@"1");
//
//    NSLog(@"333");
////    dispatch_sync(dispatch_get_main_queue(), ^{
////        NSLog(@"111");
////    });
//    NSLog(@"222");
//    SEL aa = @selector(ok:);
//   Method me = class_getInstanceMethod([self class], aa);
//   const char *a = method_getTypeEncoding(me);
//    printf(a);
//
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ok:) name:@"haha" object:nil];
//    NSLog(@"1------%@",[NSThread currentThread]);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"haha" object:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller. 
}
*/
//- (NSInteger)ok:(NSString *)par {
//    printf("jlkjlkjljl");
//    sleep(3);
//    NSLog(@"2------%@",[NSThread currentThread]);
//    return 1;
//}
//-(void)haha{
//    
//}
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    return [super resolveInstanceMethod:sel];;
//}
//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    NSLog(@"%@",NSStringFromSelector(aSelector));
//    
//   Class Common = objc_allocateClassPair([NSObject class], "Common", 0);
//   IMP h = class_getMethodImplementation([self class], @selector(haha));
//    class_addMethod(Common, aSelector, h, "@v:");
//    objc_registerClassPair(Common);
//    id fc = class_createInstance(Common, 0);
//    return fc;
//}
@end

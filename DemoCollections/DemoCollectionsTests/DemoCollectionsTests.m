//
//  DemoCollectionsTests.m
//  DemoCollectionsTests
//
//  Created by helong on 16/8/20.
//  Copyright © 2016年 helong. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface DemoCollectionsTests : XCTestCase

@end

@implementation DemoCollectionsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testTimeFormat {
    NSLog(@"1---%@",[self timeStringWithMinute:30 format:nil]);
    NSLog(@"2---%@",[self timeStringWithMinute:30 * 5 format:nil]);
    NSLog(@"3---%@",[self timeStringWithMinute:30 * 48 format:nil]);
    NSLog(@"4---%@",[self timeStringWithMinute:30 * 48 + 8 format:nil]);
}

/// 分钟转时间
/// @param minutes <#minutes description#>
/// @param format <#format description#>
- (NSString *)timeStringWithMinute:(NSUInteger)minutes format:(NSString *)format {
    NSUInteger day = 0;
    NSUInteger hour = 0;
    NSUInteger minute = 0;
    
    day = minutes / 60 / 24;
    if (day == 0) {
        hour = minutes / 60;
        if (hour == 0) {
            minute = minutes;
        }else{
            minute = minutes % 60;
        }
    }else{
        hour = (minutes - day * 24 * 60) / 60;
        if (hour == 0) {
            minute = minutes - day * 24 * 60;
        }else{
           minute = (minutes - day * 24 * 60 - hour * 60) % 60;
        }
    }
    
    NSString *dayStr = @"";
    NSString *hourStr = @"";
    NSString *minuteStr = @"";
    if (day > 0) {
        dayStr = [NSString stringWithFormat:@"%ld天",day];
    }
    if (hour > 0) {
        hourStr = [NSString stringWithFormat:@"%ld小时",hour];
    }
    if (minute > 0) {
        minuteStr = [NSString stringWithFormat:@"%ld分钟",minute];
    }
    
//
////    0-天-0-小时-30-分钟
//    NSString *timeStr = [NSString stringWithFormat:@"%ld-%ld-%ld",day,hour,minute];
//    NSArray *timeComponents = [timeStr componentsSeparatedByString:@"-"];
//    NSMutableArray *items = [NSMutableArray array];
//    for (int i = 0; i<timeComponents.count; i++) {
//        if ([timeComponents[i] integerValue] > 0) {
//            [items addObject:@(i)];
//        }
//    }
//
    return [NSString stringWithFormat:@"%@%@%@",dayStr,hourStr,minuteStr];
}

- (void)testBlock {
    __block int a = 10;
    __block NSArray *eee = @[@"kkkkk"];
    __block NSMutableArray *e = [NSMutableArray array];
    
     void(^ok)() = ^() {
         a++;
         eee = @[@"kjkj"];
         [e addObject:@"dd"];
         NSLog(@"%ld==%p===%p===%p",a,&a,eee,e);
     };
     ok();
     NSLog(@"%ld==%p===%p===%p",a,&a,eee,e);
}

- (void)testAutoRelease {
    
    @autoreleasepool {
        NSString *str = @"ddd";
        NSLog(@"1%@",str);
        @autoreleasepool {
            NSLog(@"2%@",str);
        }
    };
    
}
@end

//
//  HLLocationManager.m
//  DemoCollections
//
//  Created by 李白 on 2021/3/9.
//  Copyright © 2021 helong. All rights reserved.
//

#import "HLLocationManager.h"
#import <CoreLocation/CoreLocation.h>
@interface HLLocationManager()<CLLocationManagerDelegate>
@property(nonatomic,strong)CLLocationManager *locationManager;
@end

@implementation HLLocationManager
+ (instancetype)singleton {
    static HLLocationManager *singleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[HLLocationManager alloc] init];
    });
    return singleton;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.allowsBackgroundLocationUpdates = true;
    }
    return self;
}

- (void)requestAuthority {
    [self.locationManager requestAlwaysAuthorization];
}
- (void)start {
    
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways) {
        NSLog(@"请开启一直定位权限");
//        return;
    }
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
}
- (void)stop {
    [self.locationManager stopUpdatingLocation];
}
#pragma mark - cllocationdelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSLog(@"定位类型:%d",status);
    if (status != kCLAuthorizationStatusAuthorizedAlways) {
    }
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    NSLog(@"位置更新");
}
@end

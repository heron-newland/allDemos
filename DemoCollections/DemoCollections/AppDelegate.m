//
//  AppDelegate.m
//  DemoCollections
//
//  Created by helong on 16/8/20.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "HLAudioManager.h"
#import "HLLockStatus.h"
#import "HLResidentThread.h"
#import "HLTemporary.h"
@interface AppDelegate ()

@property(nonatomic,assign)UIBackgroundTaskIdentifier backgroundTaskIdentifier;
@property(nonatomic,assign)__block BOOL shouldCheckLockStatus;
@property(nonatomic,strong)HLResidentThread *residentThread;
@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] init];
    ViewController *rootVC = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootVC];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
//    if (!SIMULATOR) {
////         NSLog(@"真机");
//        NSLog(@"真机");
        [self redirectNSLogToDocumentFolder];
//    }
//    if (TARGET_OS_SIMULATOR) {
//        NSLog(@"模拟器");
//    }
//    TARGET_OS_IPHONE
    
    #if kShouldKeepAliveWorks
    [[HLAudioManager singleton] configAudioSession];
    __block NSInteger begin = 0;
    [NSTimer scheduledTimerWithTimeInterval:1 repeats:true block:^(NSTimer * _Nonnull timer) {
        NSLog(@"%ld====%d====%@",begin++,[HLAudioManager singleton].player.isPlaying,[HLAudioManager singleton].player);
//        if (begin == 3) {
//            [[HLAudioManager singleton].player play];
//        }
    }];

    //通过darwin通知去监听, 前台和后台都是可行的(但是如果退到后台被挂起了,那么不能再监听到),但是审核不会通过
//    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, screenLockStateChanged, NotificationLock, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
//
//    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, screenLockStateChanged, NotificationChange, NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
    
    
    self.residentThread = [[HLResidentThread alloc] init];
#endif
    
    return YES;
}
- (void)applicationDidEnterBackground:(UIApplication *)application {

    NSLog(@"%s：应用进入后台DidEnterBackground", __FUNCTION__);
    #if kShouldKeepAliveWorks
    if ([HLAudioManager singleton].available || [HLTemporary singleton].available) {
        self.backgroundTaskIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithName:@"kBgTaskName" expirationHandler:^{
            NSLog(@"马山要被杀掉了");
            if (self.backgroundTaskIdentifier != UIBackgroundTaskInvalid) {
                [[UIApplication sharedApplication] endBackgroundTask:self.backgroundTaskIdentifier];
                self.backgroundTaskIdentifier = UIBackgroundTaskInvalid;
            }
        }];
    }

    if ([HLAudioManager singleton].available) {
        [[HLAudioManager singleton] playAudio];
    }

    if ([HLTemporary singleton].available) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            while (true) {
                sleep(1);
                NSLog(@"hahahahah");
            }
        });
    }
#endif
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
//    self.shouldCheckLockStatus = false;
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"%s：应用将进入前台WillEnterForeground", __FUNCTION__);
    #if kShouldKeepAliveWorks
//    self.shouldCheckLockStatus = false;
//    [[HLAudioManager singleton] playAudio];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    if ([HLAudioManager singleton].available) {
        [[HLAudioManager singleton] stopAudio];
    }
//    });
    [[UIApplication sharedApplication] endBackgroundTask: self.backgroundTaskIdentifier];
#endif
}


- (void)redirectNSLogToDocumentFolder {
    //如果已经连接Xcode调试则不输出到文件
    if(isatty(STDOUT_FILENO)) {
        return;
    }
    UIDevice *device = [UIDevice currentDevice];
    if([[device model] hasSuffix:@"Simulator"]){ //在模拟器不保存到文件中
        return;
    }
    //将NSlog打印信息保存到Document目录下的Log文件夹下
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *logDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Log"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL fileExists = [fileManager fileExistsAtPath:logDirectory];
    if (!fileExists) {
        [fileManager createDirectoryAtPath:logDirectory  withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; //每次启动后都保存一个新的日志文件中
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    NSString *logFilePath = [logDirectory stringByAppendingFormat:@"/%@.log",dateStr];
    
    // 将log输入到文件
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
    
    //未捕获的Objective-C异常日志
    NSSetUncaughtExceptionHandler (&UncaughtExceptionHandler);
}



void UncaughtExceptionHandler(NSException* exception)
{
    NSString* name = [ exception name ];
    NSString* reason = [ exception reason ];
    NSArray* symbols = [ exception callStackSymbols ]; // 异常发生时的调用栈
    NSMutableString* strSymbols = [ [ NSMutableString alloc ] init ]; //将调用栈拼成输出日志的字符串
    for ( NSString* item in symbols )
    {
        [ strSymbols appendString: item ];
        [ strSymbols appendString: @"\r\n" ];
    }
    
    //将crash日志保存到Document目录下的Log文件夹下
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *logDirectory = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Log"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:logDirectory]) {
        [fileManager createDirectoryAtPath:logDirectory  withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *logFilePath = [logDirectory stringByAppendingPathComponent:@"UncaughtException.log"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:[NSDate date]];
    
    NSString *crashString = [NSString stringWithFormat:@"<- %@ ->[ Uncaught Exception ]\r\nName: %@, Reason: %@\r\n[ Fe Symbols Start ]\r\n%@[ Fe Symbols End ]\r\n\r\n", dateStr, name, reason, strSymbols];
    //把错误日志写到文件中
    if (![fileManager fileExistsAtPath:logFilePath]) {
        [crashString writeToFile:logFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }else{
        NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:logFilePath];
        [outFile seekToEndOfFile];
        [outFile writeData:[crashString dataUsingEncoding:NSUTF8StringEncoding]];
        [outFile closeFile];
    }
    
    //把错误日志发送到邮箱
    NSString *urlStr = [NSString stringWithFormat:@"mailto://173473642@qq.com?subject=bug报告&body=感谢您的配合!<br><br><br>错误详情:<br>%@",crashString ];
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
//    NSCharacterSet *set = [[NSCharacterSet alloc] init];
//    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEncodingWithAllowedCharacters:<#(nonnull NSCharacterSet *)#>]];
    [[UIApplication sharedApplication] openURL:url];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}





- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

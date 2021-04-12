//
//  HLAudioManager.m
//  DemoCollections
//
//  Created by 李白 on 2021/3/8.
//  Copyright © 2021 helong. All rights reserved.
//

#import "HLAudioManager.h"

@interface HLAudioManager()<AVAudioPlayerDelegate>
@end
@implementation HLAudioManager

+ (instancetype)singleton {
    static HLAudioManager *singleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[HLAudioManager alloc] init];
    });
    return singleton;
}

- (void)playAudio {
    if (!self.available) {
        if ([self.player isPlaying]) {
            [self.player stop];
        }
        return;
    }
    if ([self.audioSession secondaryAudioShouldBeSilencedHint]) {
        NSLog(@"其他app在使用音频");
    }else{
        NSLog(@"现在没有app使用音频");
        [self.player play];
    }
}
- (void)stopAudio {
    if (!self.available) {
        if ([self.player isPlaying]) {
            [self.player stop];
        }
        return;
    }
    [self.player stop];
}
/// 方案一:后台无法播放的
- (AVAudioPlayer *)player {
    if (!_player) {
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"1004523" withExtension:@"mp3"];
        AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
        audioPlayer.numberOfLoops = NSUIntegerMax;
        audioPlayer.delegate = self;
        _player = audioPlayer;
        [_player prepareToPlay];
        
    }
    return _player;
}

- (void)configAudioSession {
    if (!self.audioSession) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
//            NSError *error = nil;
//            [session setCategory:AVAudioSessionCategoryAmbient mode:AVAudioSessionCategoryPlayback options:AVAudioSessionCategoryOptionMixWithOthers error:&error];
//            NSLog(@"init error : %@",error);
        //    error = nil;
        //    [session setActive:true error:&error];
        //    NSLog(@"setActive error : %@",error);
        
        // 1. 获取音频会话
        //    AVAudioSession *session = [AVAudioSession sharedInstance];
        // 2. 设置会话分类
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
        // 3. 激活会话
        [session setActive:YES error:nil];
        self.audioSession = session;
    }
}

/* AVAudioPlayer INTERRUPTION NOTIFICATIONS ARE DEPRECATED - Use AVAudioSession instead. */

/* audioPlayerBeginInterruption: is called when the audio session has been interrupted while the player was playing. The player will have been paused. */
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player NS_DEPRECATED_IOS(2_2, 8_0) {
//    NSLog(@"",self.audioSession)
//    [self.audioSession setActive:NO error:nil];
    NSLog(@"被打断,停止播放");
    
    if (!self.available) {
        if ([self.player isPlaying]) {
            [self.player stop];
        }
        return;
    }
    [self.player pause];
    
}

/* audioPlayerEndInterruption:withOptions: is called when the audio session interruption has ended and this player had been interrupted while playing. */
/* Currently the only flag is AVAudioSessionInterruptionFlags_ShouldResume. */
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags NS_DEPRECATED_IOS(6_0, 8_0) {
//    [self.audioSession setActive:YES error:nil];
    NSLog(@"打断结束,继续播放");
    if (!self.available) {
        if ([self.player isPlaying]) {
            [self.player stop];
        }
        return;
    }
    [self.player play];
}


//- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withFlags:(NSUInteger)flags NS_DEPRECATED_IOS(4_0, 6_0) {
//
//}
//
///* audioPlayerEndInterruption: is called when the preferred method, audioPlayerEndInterruption:withFlags:, is not implemented. */
//- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player NS_DEPRECATED_IOS(2_2, 6_0) {
//
//}




@end

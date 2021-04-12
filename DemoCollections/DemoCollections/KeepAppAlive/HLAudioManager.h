//
//  HLAudioManager.h
//  DemoCollections
//
//  Created by 李白 on 2021/3/8.
//  Copyright © 2021 helong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>



NS_ASSUME_NONNULL_BEGIN

@interface HLAudioManager : NSObject
@property(nonatomic,assign)BOOL available;
@property(nonatomic,strong)AVAudioPlayer *player;
@property(nonatomic,strong)AVAudioSession *audioSession;
+ (instancetype)singleton;
- (void)configAudioSession;
- (void)playAudio;
- (void)stopAudio;
@end

NS_ASSUME_NONNULL_END

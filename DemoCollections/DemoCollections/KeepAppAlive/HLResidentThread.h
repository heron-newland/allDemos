//
//  HLResidentThread.h
//  DemoCollections
//
//  Created by 李白 on 2021/3/8.
//  Copyright © 2021 helong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HLResidentThread : NSObject
-(void)doAction:(dispatch_block_t)action;
-(void)cancel;
@end

NS_ASSUME_NONNULL_END

//
//  HLQuartzView.m
//  DemoCollections
//
//  Created by helong on 2016/10/30.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLQuartzView.h"

@implementation HLQuartzView

- (void)drawInContext:(CGContextRef )context {
    
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawInContext:context];
}


@end

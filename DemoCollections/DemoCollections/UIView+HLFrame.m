//
//  UIView+HLFrame.m
//  DemoCollections
//
//  Created by helong on 16/8/20.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "UIView+HLFrame.h"

@implementation UIView (HLFrame)

- (void)setX:(CGFloat)x {
    CGRect originFrame = self.frame;
    originFrame.origin.x = x;
    self.frame = originFrame;
}
- (CGFloat)x {
    return self.frame.origin.x;
}

-(void)setY:(CGFloat)y {
    CGRect originFrame = self.frame;
    originFrame.origin.y = y;
    self.frame = originFrame;
}
- (CGFloat)y {
     return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width {
    CGRect originFrame = self.frame;
    originFrame.size.width = width;
    self.frame = originFrame;
}
- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    CGRect originFrame = self.frame;
    originFrame.size.height = height;
    self.frame = originFrame;
}
- (CGFloat)height {
    return self.frame.size.height;
}
@end

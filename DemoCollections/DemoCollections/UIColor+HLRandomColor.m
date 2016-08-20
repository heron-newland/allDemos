//
//  UIColor+HLRandomColor.m
//  DemoCollections
//
//  Created by helong on 16/8/20.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "UIColor+HLRandomColor.h"

@implementation UIColor (HLRandomColor)
+ (UIColor *)randomColor {
    CGFloat random1 = arc4random_uniform(255) / 255.0;
    CGFloat random2 = arc4random_uniform(255) / 255.0;
    CGFloat random3 = arc4random_uniform(255) / 255.0;
    return [UIColor colorWithRed:random1 green:random2 blue:random3 alpha:1];
}
@end

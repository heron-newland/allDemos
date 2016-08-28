//
//  HLEyeView.m
//  DemoCollections
//
//  Created by helong on 16/8/27.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLEyeView.h"

@interface HLEyeView()
@property (nonatomic, assign) CGPoint centerPoint;
@end

@implementation HLEyeView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor redColor];
        
        
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    CGPoint center = CGPointMake(self.bounds.size.width *0.5, self.bounds.size.height * 0.5);
    self.centerPoint = center;
     NSLog(@"%@", NSStringFromCGPoint(self.centerPoint));
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.centerPoint radius:20 startAngle:0 endAngle:M_PI *2 clockwise:YES];
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.path = path.CGPath;
    shape.lineWidth = 4;
    shape.strokeColor = [UIColor whiteColor].CGColor;
    shape.fillColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:shape];
    
}
@end

//
//  HLQuartzLineView.m
//  DemoCollections
//
//  Created by helong on 2016/10/30.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLQuartzLineView.h"

@implementation HLQuartzLineView

- (void)drawInContext:(CGContextRef)context {
    CGContextSetLineWidth(context, 10);//设置线宽
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1 );
    //画一条单独的线
    CGContextMoveToPoint(context, 10, 100);
    CGContextAddLineToPoint(context, 10, 700);
    CGContextStrokePath(context);
    
//    CGContextMoveToPoint(context, 0, 100);
    //c语言的数组
    CGPoint addLines[] = {
        CGPointMake(50, 200),
        CGPointMake(100, 100),
        CGPointMake(150, 200),
        CGPointMake(200, 100),
        CGPointMake(250, 200),
        CGPointMake(300, 100),
    };
    
    NSLog(@"%lu",sizeof(addLines));
     NSLog(@"%lu",sizeof(addLines[0]));
    //绘制连续的线,线条收尾相连
    CGContextAddLines(context, addLines, sizeof(addLines)/sizeof(addLines[0]));
    CGContextStrokePath(context);
    
    // Draw a series of line segments. Each pair of points is a segment
    CGPoint strokeSegments[] =
    {
        CGPointMake(10.0, 350.0),
        CGPointMake(70.0, 320.0),
        CGPointMake(130.0, 350.0),
        CGPointMake(190.0, 320.0),
        CGPointMake(250.0, 350.0),
        CGPointMake(310.0, 320.0),
//         CGPointMake(350.0, 150.0),
    };
    // Bulk call to stroke a sequence of line segments.
    // Equivalent to for(i=0; i<count; i+=2) { MoveToPoint(point[i]); AddLineToPoint(point[i+1]); StrokePath(); }
    //绘制一个部分, 是不连续的线,strokeSegments[]中每两个点为一条线
    CGContextStrokeLineSegments(context, strokeSegments, sizeof(strokeSegments)/sizeof(strokeSegments[0]));
}

@end


@implementation HLQuartzCapJointWidth




- (void)awakeFromNib {
    [super awakeFromNib];
     self.lineWidth = 10.0f;
}
- (void)drawInContext:(CGContextRef)context {
    NSLog(@"%f",self.lineWidth);
   
//    DLog(@"%f",self.lineWidth);
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetLineCap(context, self.lineCap);
    CGContextSetLineJoin(context, self.lineJoin);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    
    CGPoint addlines[] = {
        CGPointMake(20, 120),
        CGPointMake(100, 220),
        CGPointMake(180, 120),
        CGPointMake(260, 220),
        CGPointMake(340, 120),
    };
    CGContextAddLines(context, addlines, sizeof(addlines)/sizeof(addlines[0]));
    CGContextStrokePath(context);
    
}

#pragma mark - set方法
- (void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
    [self setNeedsDisplay];
}
- (void)setLineJoin:(CGLineJoin)lineJoin {
    _lineJoin = lineJoin;
    [self setNeedsDisplay];
}
- (void)setLineCap:(CGLineCap)lineCap {
    _lineCap = lineCap;
    [self setNeedsDisplay];
}
- (void)setLineWidth:(CGFloat)lineWidth {
    if (lineWidth != _lineWidth) {
        _lineWidth = lineWidth;
        NSLog(@"%f",self.lineWidth);
        [self setNeedsDisplay];
        
    }
    
}
@end


@implementation HLQuartzDashView

{
    CGFloat dashPattern[10];
    size_t dashCount;
}


-(void)setDashPattern:(CGFloat *)pattern count:(size_t)count
{
    
     
    /**
     复制的函数

     @param __dst#> 复制之后的值 description#>
     @param __src#> 被复制的值 description#>
     @param __n#> 复制的长度 description#>
     @return 复制后的值
     */
    //memcpy(<#void *__dst#>, <#const void *__src#>, <#size_t __n#>)
     
     
    /**
     比较两个字符串

     @param __s1#> 比较的前值 description#>
     @param __s2#> 比较的后值 description#>
     @param __n#> 要比较的长度 description#>
     @return >0 说明前值大于后值,<0前值小于后值,=0前值等于后值
     */
    //memcmp(<#const void *__s1#>, <#const void *__s2#>, <#size_t __n#>)
    
    if ((count != dashCount) || (memcmp(dashPattern, pattern, sizeof(CGFloat) * count) != 0))
    {
        memcpy(dashPattern, pattern, sizeof(CGFloat) * count);
        dashCount = count;
        [self setNeedsDisplay];
    }
}
- (void)setPhase:(CGFloat)phase {
    _phase = phase;
    [self setNeedsDisplay];
}
- (void)drawInContext:(CGContextRef)context {
    CGContextSetLineWidth(context, 5);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
//    CGContextMoveToPoint(context, 50, 100);
    CGFloat lengths[] = {
        10,
        5,
        20,
        10,
    };
    CGContextSetLineDash(context, self.phase, dashPattern, dashCount);
    CGContextSetLineDash(context, 0.4, _pattern.pattern, sizeof(_pattern.pattern)/sizeof(_pattern.pattern[0]));
    CGContextAddRect(context, CGRectMake(100, 100, 200, 200));
    CGContextStrokePath(context);
    
}
- (void)setPattern:(Pattern)pattern {
    _pattern = pattern;
    
    for (int i = 0; i<pattern.count; i++) {
        NSLog(@"%f",pattern.pattern[i]);
    }
    [self setNeedsDisplay];
}
@end

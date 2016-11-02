//
//  HLPolygonAndRectView.m
//  DemoCollections
//
//  Created by helong on 2016/10/31.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLPolygonAndRectView.h"

@implementation HLPolygonAndRectView

/**
 set这样写在出现view的时候就会有图形绘制
 */
//-(void)setDrawingMode:(CGPathDrawingMode)drawingMode {
//    if (drawingMode != _drawingMode) {
//        _drawingMode = drawingMode;
//        [self setNeedsDisplay];
//    }
//}
-(void)setDrawingMode:(CGPathDrawingMode)drawingMode {
//    if (drawingMode != _drawingMode) {
        _drawingMode = drawingMode;
        [self setNeedsDisplay];
//    }
}
- (void)drawInContext:(CGContextRef)context {
    CGContextSetLineWidth(context, 5);
    CGContextSetRGBStrokeColor(context, 1, 1, 1, 1);
    CGContextSetRGBFillColor(context, 0, 0, 1, 1);
    //绘制六边形
    CGPoint center = CGPointMake(120, 240);
    CGContextMoveToPoint(context, 120, 240 - 80);
    CGFloat radius = 80;
    for (int i = 0; i < 6; i++) {
        CGFloat pointX = center.x + radius * sinf(M_PI * 2 / 6 * i);
        CGFloat pointY = center.y - radius * cosf(M_PI * 2 / 6 * i);
        CGContextAddLineToPoint(context, pointX, pointY);
        
    }
      CGContextClosePath(context);
    //绘制五角星
    CGPoint center1 = CGPointMake(290, 240);
    CGContextMoveToPoint(context, 290, 240 - 80);
    CGFloat radius1 = 80;
    for (int i = 0; i < 5; i++) {
        CGFloat pointX = center1.x + radius1 * sinf(2 * M_PI * 2 / 5 * i);
        CGFloat pointY = center1.y - radius1 * cosf(2 * M_PI * 2 / 5 * i);
        CGContextAddLineToPoint(context, pointX, pointY);
        
    }
    CGContextClosePath(context);
 
        CGContextDrawPath(context, self.drawingMode);
  
}

@end

@implementation HLRectTangleView

- (void)drawInContext:(CGContextRef)context {
    //第一种方法
    CGContextSetLineWidth(context, 2);
    CGContextSetRGBStrokeColor(context, 1, 1, 1, 1);
    CGContextAddRect(context, CGRectMake(30, 100, 100, 100));
    CGContextStrokePath(context);
    //第二种方法
    CGContextStrokeRect(context, CGRectMake(30, 230, 100, 100));
    CGContextStrokePath(context);
    //第三种方法
    CGContextStrokeRectWithWidth(context, CGRectMake(30, 360, 100, 100), 2);
    //第四种方法,批量画
    CGRect rects[] = {
        CGRectMake(30, 490, 100, 100),
        CGRectMake(30, 620, 100, 100)
    };
    CGContextAddRects(context, rects, sizeof(rects)/sizeof(rects[0]));
    CGContextStrokePath(context);
    
    //绘制带有中间线的rect
    CGContextStrokeRectWithWidth(context, CGRectMake(160.0, 100.0, 100.0, 100.0), 10.0);
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    CGContextStrokeRectWithWidth(context, CGRectMake(160.0, 100.0, 100.0, 100.0), 2.0);
    
    //实心填充的第一种方法
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, CGRectMake(160.0, 230.0, 100.0, 100.0));
    //实心填充的第二种方法
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextAddRect(context, CGRectMake(160.0, 360.0, 100.0, 100.0));
    CGContextFillPath(context);
    //实心填充的第三种方法:批量创建的方法,同上.....
    
}

@end


/**
 操作图形上下文栈
 */
@implementation HLSaveContextView

- (void)drawInContext:(CGContextRef)context {
    
}

@end



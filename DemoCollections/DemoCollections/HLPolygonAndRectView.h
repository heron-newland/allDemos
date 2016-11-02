//
//  HLPolygonAndRectView.h
//  DemoCollections
//
//  Created by helong on 2016/10/31.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLQuartzView.h"

/**
 绘制多边形
 */
@interface HLPolygonAndRectView : HLQuartzView
@property (nonatomic, assign) CGPathDrawingMode drawingMode;
@end


/**
 绘制矩形的多种方式
 */
@interface HLRectTangleView : HLQuartzView

@end


/**
 操作图形上下文栈
 */
@interface HLSaveContextView : HLQuartzView

@end

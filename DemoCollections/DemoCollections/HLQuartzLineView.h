//
//  HLQuartzLineView.h
//  DemoCollections
//
//  Created by helong on 2016/10/30.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLQuartzView.h"

@interface HLQuartzLineView : HLQuartzView

@end

/**
 绘制线条的多种方式
 */
@interface HLQuartzCapJointWidth : HLQuartzView
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGLineCap lineCap;
@property (nonatomic, assign) CGLineJoin lineJoin;
@property (nonatomic, weak) UIColor *lineColor;
@end


/**
 绘制点画线的方式
 */
@interface HLQuartzDashView : HLQuartzView

/**
 自定义结构体
 */
typedef struct {
    CGFloat pattern[5];//点画线的数组
    size_t count;//点画线数组的个数,方便for循环计算count
}Pattern;

@property (nonatomic, assign)Pattern pattern;
@property (nonatomic, assign) CGFloat phase;
@end

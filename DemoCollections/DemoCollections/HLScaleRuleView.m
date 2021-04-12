//
//  HLScaleRuleView.m
//  DemoCollections
//
//  Created by 李白 on 2021/4/8.
//  Copyright © 2021 helong. All rights reserved.
//

#import "HLScaleRuleView.h"


@interface HLScaleRuleView (){
    NSInteger _width;
    NSInteger _height;
}

@end

@implementation HLScaleRuleView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.scaleFactor = 1;
        _width = 50;
        _height = 30;
    }
    return self;
}

- (void)setScaleFactor:(CGFloat)scaleFactor {
    _scaleFactor = scaleFactor;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    NSInteger distance = 40 * self.scaleFactor;
    NSInteger bigLength = 10;
    NSInteger smallLength = 5;
    CGRect textRect;
    CGSize textSize;
    NSString *str;
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    
    for (int i = 0; i<(int)_width/5; i++) {
        str = [NSString stringWithFormat:@"%d",i * 40];
        textSize = [str boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading attributes:nil context:nil].size;
        CGContextMoveToPoint(context, distance * (i +  1), 0);
        if (i % 2 == 0) {
            textRect = CGRectMake(distance * (i +  1) - textSize.width * 0.5, bigLength, textSize.width, textSize.height);
            CGContextAddLineToPoint(context, distance * (i +  1), bigLength);
        }else{
            textRect = CGRectMake(distance * (i +  1) - textSize.width * 0.5, smallLength, textSize.width, textSize.height);
            CGContextAddLineToPoint(context, distance * (i +  1), smallLength);
        }
        [str drawInRect:textRect withAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    }
    
    for (int i = 0; i<(int)_height/3; i++) {
        str = [NSString stringWithFormat:@"%d",i * 40];
        textSize = [str boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading attributes:nil context:nil].size;
        CGContextMoveToPoint(context, 0, distance * (i +  1));
        if (i % 2 == 0) {
            textRect = CGRectMake(bigLength, distance * (i +  1) - textSize.height * 0.5, textSize.width, textSize.height);
            CGContextAddLineToPoint(context, bigLength, distance * (i +  1));
        }else{
            textRect = CGRectMake(smallLength, distance * (i +  1) - textSize.height * 0.5, textSize.width, textSize.height);
            CGContextAddLineToPoint(context, smallLength, distance * (i +  1));
        }
        [str drawInRect:textRect withAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSVerticalGlyphFormAttributeName:@1}];
    }
    
    CGContextStrokePath(context);
    

    
}


@end

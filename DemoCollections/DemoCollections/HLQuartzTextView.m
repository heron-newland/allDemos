//
//  HLQuartzTextView.m
//  DemoCollections
//
//  Created by 李白 on 2021/4/7.
//  Copyright © 2021 helong. All rights reserved.
//

#import "HLQuartzTextView.h"
#import <QuartzCore/QuartzCore.h>

@interface HLQuartzTextView ()
@property(nonatomic,weak)UITextField *textField;
@property(nonatomic,assign)CGFloat deltaX;
@property(nonatomic,assign)CGFloat deltaY;

@end
@implementation HLQuartzTextView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        
        
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(10, 100, 100, 44)];
        tf.backgroundColor = [UIColor greenColor];
        [self addSubview:tf];
//        [tf setEnabled:false];
        tf.placeholder = @"双击添加文字";
        tf.layer.borderColor = [UIColor blueColor].CGColor;
        tf.layer.borderWidth = 8;
        self.textField = tf;
        
        
        
        
        
        self.textField.gestureRecognizers = nil;
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
        [self.textField addGestureRecognizer:pan];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        tap.numberOfTapsRequired = 2;
        [self.textField addGestureRecognizer:tap];
    }
    return self;
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    UITouch *touch = event.allTouches.anyObject;
//    if (touch.tapCount == 2) {
//        CGPoint p = [self convertPoint:point toView:self.textField];
//        if ([self.textField pointInside:p withEvent:event]) {
//            [self.textField setEnabled:true];
//             [self.textField becomeFirstResponder];
//        }
//    }
//    return [super hitTest:point withEvent:event];
//}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textField endEditing:true];
}
- (void)tapGestureAction:(UIGestureRecognizer *)gesture {
//    [self.textField setEnabled:true];
    [self.textField becomeFirstResponder];
}
- (void)panGestureAction:(UIGestureRecognizer *)gesture {
    
    CGPoint currentPoint, beginPoint;
    
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            beginPoint = [gesture locationInView:self];
            self.deltaX = beginPoint.x - self.textField.frame.origin.x;
            self.deltaY = beginPoint.y - self.textField.frame.origin.y;
            NSLog(@"begin");
            break;
        case UIGestureRecognizerStateChanged:
            currentPoint = [gesture locationInView:self];
            NSLog(@"changed");
            NSLog(@"pan");
            self.textField.frame = CGRectMake(currentPoint.x - self.deltaX, currentPoint.y - self.deltaY, self.textField.frame.size.width, self.textField.frame.size.height);
            [self.textField setNeedsLayout];
            [self setNeedsDisplay];
            break;
        case UIGestureRecognizerStateCancelled:
            NSLog(@"cancel");
            break;
        case UIGestureRecognizerStateEnded:
            currentPoint = [gesture locationInView:self];
            NSLog(@"end");
            break;
        default:
            break;
    }
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat length[2] = {3,3};
    CGContextSetLineDash(context, 1, length, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextMoveToPoint(context, self.textField.frame.origin.x, 0);
    CGContextAddLineToPoint(context, self.textField.x, self.bounds.size.height);
    CGContextStrokePath(context);
    
    CGContextSaveGState(context);
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    CGContextMoveToPoint(context, 0, self.textField.frame.origin.y);
    CGContextAddLineToPoint(context, self.bounds.size.width, self.textField.frame.origin.y);
    CGContextStrokePath(context);
    
    CGContextRestoreGState(context);
    CGContextMoveToPoint(context, CGRectGetMaxX(self.textField.frame), 0);
    CGContextAddLineToPoint(context, CGRectGetMaxX(self.textField.frame), self.bounds.size.height);
    CGContextStrokePath(context);
    
    NSString *testStr = @"极乐空间";
    [testStr drawInRect:CGRectMake(0, 100, 100, 44) withAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, CGRectGetMaxY(self.textField.frame));
    CGPathAddLineToPoint(path, NULL, self.bounds.size.width, CGRectGetMaxY(self.textField.frame));
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
    CGPathRelease(path);
    
    UIImage *img = [UIImage imageNamed:@"gesture_node_error"];
    [img drawInRect:CGRectMake(0, 130, 20, 20)];
    
}


@end

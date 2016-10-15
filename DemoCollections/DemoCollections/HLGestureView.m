//
//  HLGestureView.m
//  手势密码
//
//  Created by helong on 5/21/16.
//  Copyright © 2016 helong. All rights reserved.
//

#import "HLGestureView.h"
//  按钮的个数
#define BUTTON_COUNT 9
//  每行按钮布局的个数
#define COL_NUM 3
//  按钮的大小: 长宽相等
#define BUTTON_SIZE 74

@interface HLGestureView()
/**
 *  按钮集合
 */
@property (nonatomic ,strong) NSMutableArray <UIButton *>*btnArray;
/**
 *  高亮状态的按钮集合
 */
@property (nonatomic ,strong) NSMutableArray <UIButton *>*btnHLArray;
/**
 *  线条的颜色
 */
@property (nonatomic ,weak) UIColor *lineColor;
/**
 *  记录用户手势滑动的位置
 */
@property (nonatomic ,assign) CGPoint loaction;

@end


@implementation HLGestureView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"HomeButtomBG"]];
    }
    return self;
}
#pragma mark -连线
- (void)drawRect:(CGRect)rect{
    
    UIBezierPath *path = [[UIBezierPath alloc]init];
    //  将高亮的按钮用线段连接起来
    for (NSInteger i = 0; i < self.btnHLArray.count; i++) {
        if (i == 0) {
            [path moveToPoint:self.btnHLArray[i].center];
        }else{
        [path addLineToPoint:self.btnHLArray[i].center];
        }
    }
    if (self.btnHLArray > 0) {
        
        [path addLineToPoint:self.loaction];
    }
//    NSLog(@"%@",NSStringFromCGPoint(self.loaction));
    //  设置线宽
    [path setLineWidth:5];
    //  设置线条的颜色
    [self.lineColor set];
    
    [path stroke];
    
}

#pragma mark -触摸开始事件
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //  获取用户手指的坐标
    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:self];
    self.loaction = location;
    //  将用户触摸的按钮高亮,并保存在高亮按钮数组中
    for (UIButton *btn in self.btnArray) {
        if (CGRectContainsPoint(btn.frame, location) && btn.highlighted == NO) {
            btn.highlighted = YES;//设置按钮的高亮状态
            [self.btnHLArray addObject:btn];
        }
    }
    [self setNeedsDisplay];
}

#pragma mark - 触摸后移动事件
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
      //  获取用户手指的坐标
    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:self];
    self.loaction = location;
    //  将用户触摸的按钮高亮,并保存在高亮按钮数组中
    for (UIButton *btn in self.btnArray) {
        if (CGRectContainsPoint(btn.frame, location)&& btn.highlighted == NO) {
            btn.highlighted = YES;
            [self.btnHLArray addObject:btn];

        }
    }
    [self setNeedsDisplay];
}

#pragma mark - 触摸结束的事件
//  判断用户手势密码的正确与否
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    self.loaction = self.btnHLArray.lastObject.center;//绘制结束后将线的终点放在最后一个按钮上
#warning 从本地或者服务器请求密码
    NSString *passWordString = @"0125";//设置正确密码
    
    //根据按钮的tag,拼接密码字符串
    NSMutableString *passWordArray = [NSMutableString string];
    for (UIButton *btn in self.btnHLArray) {
        [passWordArray appendString:[NSString stringWithFormat:@"%ld",btn.tag]];
    }
    
    //判断密码是否正确
    if ([passWordArray isEqualToString:passWordString]) {//密码正确
        self.lineColor = [UIColor greenColor];
        [self setNeedsDisplay];
        //  延迟后恢复
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self clear];
        });
        
    }else{//密码不正确
        
        for (UIButton *btn in self.btnHLArray) {
            //  线设置红色
            self.lineColor = [UIColor redColor];
            [self setNeedsDisplay];
            //  取消高亮
            btn.highlighted = NO;
            //  变成选中状态
            btn.selected = YES;
            //  绘制之后禁止交互
            self.userInteractionEnabled = NO;
            //  延迟后恢复
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [self clear];
//                //  清除之后开启交互，用户重新绘制
                self.userInteractionEnabled = YES;

            });
        }
    }
}

#pragma mark -九宫格加载按钮
- (void)layoutSubviews{
    //  按钮的个数
    NSInteger btnCount = BUTTON_COUNT;
    //  每一行按钮的个数
    NSInteger colNum = COL_NUM;
    //  按钮的大小
    CGFloat btnW = BUTTON_SIZE;//根据图片的尺寸定按钮的大小
    CGFloat btnH = BUTTON_SIZE;
    //  按钮的间距
    CGFloat margin = (self.width - colNum * btnW) / (colNum - 1);
    //  循环创建按钮, 并添加到数组
    for (int i = 0; i < btnCount; i++) {
        NSInteger colums = i % colNum;
        NSInteger row = i /colNum;
        CGFloat btnX = colums * (btnW + margin);
        CGFloat btnY =row * (btnW + margin);
        //设置按钮三种状态的图片
        self.btnArray[i].frame = CGRectMake(btnX, btnY, btnW, btnH);
    }

}

#pragma mark - 手势完成之后清楚线条和状态
- (void)clear
{
    
    //恢复线条原先颜色
    self.lineColor = [UIColor whiteColor];
    
    //1. 取消按钮的高亮状态
    for(UIButton *Btn in self.btnHLArray){
        Btn.selected = NO;
        Btn.highlighted = NO;
    }
    
    
    //2.清除画线
    
    [self.btnHLArray removeAllObjects];
    
    //重绘
    [self setNeedsDisplay];
    
    
}
#pragma mark -懒加载按钮
//  懒加载所有的按钮数组
- (NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
        
        NSInteger btnCount = 9;
        
        for (int i = 0; i < btnCount; i++) {
        
            UIButton *btn = [[UIButton alloc]init];
            //  关闭用户交互, 因为他要响应手势
            btn.userInteractionEnabled = NO;
            //  标记tag,用于判断密码正确与否
            btn.tag = i;
            //设置按钮三种状态的图片
            [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateHighlighted];
            [btn setImage:[UIImage imageNamed:@"gesture_node_error"] forState:UIControlStateSelected];

            [self addSubview:btn];
            
            [_btnArray addObject:btn];
        }
    }
    return _btnArray;
}
//  懒加载高亮按钮数组
- (NSMutableArray<UIButton *> *)btnHLArray{
    if (!_btnHLArray) {
        _btnHLArray = [NSMutableArray array];
    }
    return _btnHLArray;
}
//  懒加载线的颜色
- (UIColor *)lineColor{
    if (!_lineColor) {
        _lineColor = [UIColor whiteColor];
    }
    return _lineColor;
}
@end

//
//  HLRedaController.m
//  DemoCollections
//
//  Created by helong on 16/8/20.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLRedaController.h"
@interface HLRedaController()
@property (strong, nonatomic) UIView *testView;
@end
@implementation HLRedaController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self effectiveOne];
    [self effectiveTwo];
    
}
/**
 *  波纹效果
 */
- (void)effectiveOne {
    //  测试的view
    _testView=[[UIView alloc] initWithFrame:CGRectMake(50, 150, 100, 100)];
    [self.view addSubview:_testView];
    //  测试view的layer设置
    CAShapeLayer *pulseLayer = [CAShapeLayer layer];
    pulseLayer.frame = _testView.layer.bounds;
     pulseLayer.path = [UIBezierPath bezierPathWithOvalInRect:pulseLayer.bounds].CGPath;
    pulseLayer.lineWidth = 4;
    pulseLayer.fillColor = [UIColor clearColor].CGColor;
    pulseLayer.strokeColor = [UIColor redColor].CGColor;
   //   复制layer
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = _testView.bounds;
    replicatorLayer.instanceCount = 4;
    replicatorLayer.instanceDelay = 2;
  
    
    [replicatorLayer addSublayer:pulseLayer];
    [_testView.layer addSublayer:replicatorLayer];
    //  layer缩放的动画
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    scaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1, 1, 0)];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 2, 2, 0)];
    //  layer 透明度改变的动画
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @0.5;
    opacityAnimation.toValue = @0.0;
    //  将缩放和透明度动画放在组动画中
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[scaleAnimation, opacityAnimation];
    group.duration = 15;
    group.repeatCount = HUGE;
    group.autoreverses = NO;
    //  将组动画添加到layer上
    [pulseLayer addAnimation:group forKey:@"groupAnimation"];
}

/**
 *  波纹，咻一咻，雷达效果
 */
- (void)effectiveTwo
{
    _testView=[[UIView alloc] initWithFrame:CGRectMake(100, 400, 300, 300)];
    [self.view addSubview:_testView];
    
    _testView.layer.backgroundColor = [UIColor clearColor].CGColor;
    CAShapeLayer *pulseLayer = [CAShapeLayer layer];
    pulseLayer.frame = _testView.layer.bounds;
    pulseLayer.path = [UIBezierPath bezierPathWithOvalInRect:pulseLayer.bounds].CGPath;
    pulseLayer.strokeColor = [UIColor redColor].CGColor;//填充色
        pulseLayer.opacity = 0.0;
    
    CAReplicatorLayer *replicatorLayer = [CAReplicatorLayer layer];
    replicatorLayer.frame = _testView.bounds;
    replicatorLayer.instanceCount = 4;//创建副本的数量,包括源对象。
    replicatorLayer.instanceDelay = 1;//复制副本之间的延迟
    [replicatorLayer addSublayer:pulseLayer];
    [_testView.layer addSublayer:replicatorLayer];
    
    CABasicAnimation *opacityAnima = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnima.fromValue = @(0.3);
    opacityAnima.toValue = @(0.0);
    
    CABasicAnimation *scaleAnima = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnima.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.0, 0.0, 0.0)];
    scaleAnima.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
    
    CAAnimationGroup *groupAnima = [CAAnimationGroup animation];
    groupAnima.animations = @[opacityAnima, scaleAnima];
    groupAnima.duration = 4.0;
    groupAnima.autoreverses = NO;
    groupAnima.repeatCount = HUGE;
    [pulseLayer addAnimation:groupAnima forKey:@"groupAnimation"];
}
@end

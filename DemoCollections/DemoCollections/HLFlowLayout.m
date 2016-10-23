//
//  HLFlowLayout.m
//  DemoCollections
//
//  Created by helong on 2016/10/23.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLFlowLayout.h"

@implementation HLFlowLayout
#pragma mark - 初始化布局
- (void)prepareLayout {
    [super prepareLayout];
    
    CGFloat inset = (self.collectionView.frame.size.width - self.itemSize.width) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
//    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
}

#pragma mark - 为每个cell指定布局属性
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    //  或者去super的布局数组
    NSArray *arr = [super layoutAttributesForElementsInRect:rect];
    //  计算collectionview的中心
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    //  在之前的基础上进行修改布局属性
    for (UICollectionViewLayoutAttributes *att in arr) {
      CGFloat centerSet = ABS(att.center.x - centerX);
        CGFloat scale = 1 - centerSet / self.collectionView.frame.size.width;
        att.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return arr;
}
#pragma mark - 返回值决定停止滚动的偏移量,可以让cell停止滚动时停在指定的位置

/**
 注意两个偏移量的区别:
 roposedContentOffset :甩动手势cell会滑动一段时间后停止,偏移量是cell停止滑动时的偏移量
 self.collectionView.contentOffset:甩动手势cell会滑动一段时间后停止,偏移量是手指离开屏幕时的偏移量


 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    NSLog(@"%@",NSStringFromCGPoint(proposedContentOffset));
    NSLog(@"%@",NSStringFromCGPoint(self.collectionView.contentOffset));
    //  计算出最终显示的矩形框
    CGFloat rectX = proposedContentOffset.x;
    CGFloat rectY = proposedContentOffset.y;
//    CGSize size = self.collectionView.frame.size;
    NSArray *arr = [super layoutAttributesForElementsInRect:CGRectMake(rectX, rectY, self.collectionView.frame.size.width, self.collectionView.frame.size.height)];
    //  获取collectionview的中心点
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    //  找出和中心间距最小的cell,让其显示在正中间
    CGFloat minSpacing = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *att in arr) {
        CGFloat res = ABS(att.center.x - centerX);
        if (ABS(minSpacing) > res) {
            minSpacing  = att.center.x - centerX;
        }
    }
    proposedContentOffset.x = proposedContentOffset.x + minSpacing;
    return proposedContentOffset;
}

#pragma mark - 当cell的大小变化,重新布局cell

/**
 重新布局会再次调用两个方法
 - (void)prepareLayout
 - (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}
@end

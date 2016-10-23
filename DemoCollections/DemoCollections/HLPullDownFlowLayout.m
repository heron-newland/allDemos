//
//  HLPullDownFlowLayout.m
//  DemoCollections
//
//  Created by helong on 2016/10/23.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLPullDownFlowLayout.h"

@interface HLPullDownFlowLayout ()
@property (nonatomic, strong) NSMutableArray *attributes;
@end
@implementation HLPullDownFlowLayout
#pragma mark - 初始化布局
- (void)prepareLayout {
    [super prepareLayout];
//    self.attributes = nil;
//    NSInteger count = [self.collectionView numberOfItemsInSection:0];
//    for (int i = 0; i<count; i++) {
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
//        UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//         CGFloat width = self.collectionView.frame.size.width * 0.5;
//        if (i == 0) {
//            CGFloat x = 0;
//            CGFloat y = 0;
//            CGFloat width = kScreenWidth * 0.5;
//            CGFloat height = width;
//            attribute.frame = CGRectMake(x, y, width, height);
//        }
//        if (i == 1) {
//            CGFloat x = kScreenWidth * 0.5;
//            CGFloat y = 0;
//            CGFloat width = kScreenWidth * 0.5;
//            CGFloat height = width * 0.5;
//            attribute.frame = CGRectMake(x, y, width, height);
//        }
//        if (i == 2) {
//            CGFloat x = kScreenWidth * 0.5;
//            CGFloat y = kScreenWidth * 0.5 * 0.5;
//            CGFloat width = kScreenWidth * 0.5;
//            CGFloat height = width * 0.5;
//            attribute.frame = CGRectMake(x, y, width, height);
//        }
//        if (i == 3) {
//            CGFloat x = 0;
//            CGFloat y = kScreenWidth * 0.5;
//            CGFloat width = kScreenWidth * 0.5;
//            CGFloat height = width * 0.5;
//            attribute.frame = CGRectMake(x, y, width, height);
//        }
//        if (i == 4) {
//            CGFloat x = 0;
//            CGFloat y = kScreenWidth * 0.75;
//            CGFloat width = kScreenWidth * 0.5;
//            CGFloat height = width * 0.5;
//            attribute.frame = CGRectMake(x, y, width, height);
//        }
//        if (i == 0) {
//            CGFloat x = kScreenWidth * 0.5;
//            CGFloat y = kScreenWidth * 0.5;
//            CGFloat width = kScreenWidth * 0.5;
//            CGFloat height = width;
//            attribute.frame = CGRectMake(x, y, width, height);
//        }
//        [self.attributes addObject:attribute];
//    }
    [super prepareLayout];
    
    [self.attributes removeAllObjects];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        // 创建UICollectionViewLayoutAttributes
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        // 设置布局属性
        CGFloat width = self.collectionView.frame.size.width * 0.5;
        if (i == 0) {
            CGFloat height = width;
            CGFloat x = 0;
            CGFloat y = 0;
            attrs.frame = CGRectMake(x, y, width, height);
        } else if (i == 1) {
            CGFloat height = width * 0.5;
            CGFloat x = width;
            CGFloat y = 0;
            attrs.frame = CGRectMake(x, y, width, height);
        } else if (i == 2) {
            CGFloat height = width * 0.5;
            CGFloat x = width;
            CGFloat y = height;
            attrs.frame = CGRectMake(x, y, width, height);
        } else if (i == 3) {
            CGFloat height = width * 0.5;
            CGFloat x = 0;
            CGFloat y = width;
            attrs.frame = CGRectMake(x, y, width, height);
        } else if (i == 4) {
            CGFloat height = width * 0.5;
            CGFloat x = 0;
            CGFloat y = width + height;
            attrs.frame = CGRectMake(x, y, width, height);
        } else if (i == 5) {
            CGFloat height = width;
            CGFloat x = width;
            CGFloat y = width;
            attrs.frame = CGRectMake(x, y, width, height);
        } else {
            UICollectionViewLayoutAttributes *lastAttrs = self.attributes[i - 6];
            CGRect lastFrame = lastAttrs.frame;
            lastFrame.origin.y += 2 * width;
            attrs.frame = lastFrame;
        }
        
        // 添加UICollectionViewLayoutAttributes
        [self.attributes addObject:attrs];
    }
}
#pragma mark - 可以滑动的区域
/**
 * 返回collectionView的内容大小
 */
- (CGSize)collectionViewContentSize
{
    int count = (int)[self.collectionView numberOfItemsInSection:0];
    int rows = (count + 3 - 1) / 3;
    CGFloat rowH = self.collectionView.frame.size.width * 0.5;
    return CGSizeMake(0, rows * rowH);
}
#pragma mark - 返回每个cell对应的属性数组
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributes;
}
#pragma mark - 懒加载
- (NSMutableArray *)attributes {
    if (!_attributes) {
        _attributes = [NSMutableArray array];
    }
    return _attributes;
}
@end

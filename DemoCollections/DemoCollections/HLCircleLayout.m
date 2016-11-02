//
//  HLCircleLayout.m
//  DemoCollections
//
//  Created by helong on 2016/10/23.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLCircleLayout.h"

@interface HLCircleLayout ()
@property (nonatomic, strong) NSMutableArray *attributes;
@end
@implementation HLCircleLayout

- (void)prepareLayout {
    [super prepareLayout];
    [self.attributes removeAllObjects];
    
    CGFloat centerX = self.collectionView.bounds.size.width * 0.5;
    CGFloat centerY = self.collectionView.bounds.size.height * 0.5;
    CGFloat radius = 120;
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    CGFloat angle = M_PI * 2 / count;
    for (int i = 0; i<count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        CGFloat itemCenterX = centerX + radius * sin(angle * i);
        CGFloat itemCenterY = centerY - radius *cos(angle * i);
        
        attribute.size = CGSizeMake(100, 100);
        attribute.center = CGPointMake(itemCenterX, itemCenterY);
        [self.attributes addObject:attribute];
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
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

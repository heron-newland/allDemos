//
//  HLLabel.h
//  DemoCollections
//
//  Created by helong on 2016/9/26.
//  Copyright © 2016年 helong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLLabel : UILabel
/**
 *  可以调整内容和边框间距的label
 *  @param 四边的间距,分别是 上 左 下 右
 */
- (instancetype)initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets)insets;

@end

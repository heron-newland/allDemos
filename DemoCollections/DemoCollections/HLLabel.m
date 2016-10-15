//
//  HLLabel.m
//  DemoCollections
//
//  Created by helong on 2016/9/26.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLLabel.h"
@interface HLLabel()
@property (nonatomic, assign) UIEdgeInsets insets;
@end

@implementation HLLabel

- (instancetype)initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets)insets {
    if (self = [super initWithFrame:frame]) {
        self.insets = insets;
    }
    return self;
}
#pragma mark - 自定义文本和边框间距的label
///将文字重新按照响应的insets重新绘制在UILabel上
- (void)drawTextInRect:(CGRect)rect {
//    CGRect newRect = CGRectMake(rect.origin.x + 10, rect.origin.y + 10, rect.size.width - 20, rect.size.height -20);
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect,self.insets)];
    
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    
    UIEdgeInsets insets =self.insets;
    
    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, insets)
                  
                  limitedToNumberOfLines:numberOfLines];
    
    rect.origin.x -= insets.left;
    
    rect.origin.y -= insets.top;
    
    rect.size.width += (insets.left+ insets.right);
    
    rect.size.height += (insets.top+ insets.bottom);
    
    return rect;
    
}

@end

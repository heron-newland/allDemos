//
//  HLConstrainView.m
//  DemoCollections
//
//  Created by helong on 2016/10/30.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLConstrainView.h"

@interface HLConstrainView ()
@property (nonatomic, weak) UILabel *label;
@end
@implementation HLConstrainView
- (instancetype)init {
    if (self = [super init]) {
//        self.backgroundColor = [UIColor grayColor];
        UILabel *label = [[UILabel alloc] init];
        label.text = @"爱我中华";
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        self.label = label;
//        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.mas_equalTo(self).insets(UIEdgeInsetsMake(200, 30, 200, 30));
//        }];
    }
    return self;
}
+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}
//- (void)layoutSubviews {
//    [super layoutSubviews];
//    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self).insets(UIEdgeInsetsMake(200, 30, 200, 30));
//    }];
//}
- (void)updateConstraints {
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).insets(UIEdgeInsetsMake(200, 30, 200, 30));
    }];
    [super updateConstraints];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

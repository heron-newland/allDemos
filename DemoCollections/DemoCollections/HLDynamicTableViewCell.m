//
//  HLDynamicTableViewCell.m
//  DemoCollections
//
//  Created by helong on 16/9/8.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLDynamicTableViewCell.h"

@interface HLDynamicTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end
@implementation HLDynamicTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}
- (void)setTitleArray:(NSArray *)titleArray {
    _titleArray = titleArray;
    self.label.text = _titleArray.firstObject;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

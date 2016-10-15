//
//  HLDrawTextView.m
//  DemoCollections
//
//  Created by helong on 2016/10/15.
//  Copyright © 2016年 helong. All rights reserved.
//

#import "HLDrawTextView.h"

@implementation HLDrawTextView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    NSString *str = @"外交部部长助理孔铉佑在吹风会上介绍说，习近平主席此访是党的十八大以来我主要领导人首次访问柬埔寨，对于巩固中柬传统友好、进一步深化双方全面战略合作具有重要意义。";
    //绘制文字可以不用获得上下文,好像oc的api自动开启了
    NSDictionary *attributesDictionary = @{
                                           NSForegroundColorAttributeName :[ UIColor blackColor ],
                                           NSFontAttributeName :[UIFont systemFontOfSize:30],
                                           };
    [str drawAtPoint:CGPointMake ( 0 , 100 ) withAttributes:attributesDictionary];

}


@end

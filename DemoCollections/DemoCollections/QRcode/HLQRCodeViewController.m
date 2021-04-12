//
//  HLQRCodeViewController.m
//  DemoCollections
//
//  Created by 李白 on 2021/2/9.
//  Copyright © 2021 helong. All rights reserved.
//

#import "HLQRCodeViewController.h"

@interface HLQRCodeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *qrImgV;
@property(nonatomic,strong)CIImage *qrImage;
@property (weak, nonatomic) IBOutlet UISlider *slideV;
@property(nonatomic,assign)CGFloat imageW;
@end

@implementation HLQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view from its nib.
    self.imageW = 240;
    [self generateQRCodeImage];
    [self.slideV addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.qrImgV.bounds = CGRectMake(0, 0, self.imageW, self.imageW);
       self.qrImgV.center = self.view.center;
}
- (void)generateQRCodeImage {
  NSData *data = [@"https://www.baidu.com" dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:NO];
   
  // 创建并设置CIFilter对象
  CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
  [filter setValue:data forKey:@"inputMessage"];
  [filter setValue:@"Q" forKey:@"inputCorrectionLevel"];
   
  // 获取生成的CIImage对象
    self.qrImage = filter.outputImage;
//    self.qrImgV.image = [UIImage imageWithCIImage:self.qrImage];
//    return;
    UIImage *img = [self resizeImage:[UIImage imageWithCIImage:self.qrImage] withQuality:kCGInterpolationNone rate:5];

  // 转换成UIImage对象，并显示在图像视图中
  self.qrImgV.image = img;
}

- (UIImage *)resizeImage:(UIImage *)image
             withQuality:(CGInterpolationQuality)quality
                    rate:(CGFloat)rate {
    UIImage *resized = nil;
    CGFloat width = image.size.width * rate;
    CGFloat height = image.size.height * rate;
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, quality);
    [image drawInRect:CGRectMake(0, 0, width, height)];
    resized = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resized;
}


- (void)valueChange:(UISlider *)sender {
    NSLog(@"%02lf",sender.value);
    self.imageW = sender.value;
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
}
@end

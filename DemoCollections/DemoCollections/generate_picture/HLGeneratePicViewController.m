//
//  HLGeneratePicViewController.m
//  DemoCollections
//
//  Created by 李白 on 2021/2/3.
//  Copyright © 2021 helong. All rights reserved.
//

#import "HLGeneratePicViewController.h"
#import <Photos/Photos.h>
@interface HLGeneratePicViewController ()
@property(nonatomic,weak)UIView *container;
@end

@implementation HLGeneratePicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blueColor];
    
   UIImage *img = [self createNonInterpolatedUIImageFormCIImage:[self createQRForString:@"https://www.baidu.com"] withSize:100];
    UIView *container_ = [[UIView alloc] initWithFrame:CGRectMake(20, 50, 200, 300)];
    container_.backgroundColor = [UIColor yellowColor];
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    imgV.center = container_.center;
    [container_ addSubview:imgV];
    imgV.image = img;
    [self.view addSubview:container_];
    self.container = container_;
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    lbl.textColor = [UIColor blackColor];
    lbl.text = @"哈哈哈我是谁";
    [self.container addSubview:lbl];
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self onDownloadTap];
}

- (CIImage *)createQRForString:(NSString *)qrString {
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    // 创建filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 设置内容和纠错级别
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    // 返回CIImage
    return qrFilter.outputImage;
}

- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // 创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // 保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

- (void)onDownloadTap {
   
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status == PHAuthorizationStatusAuthorized) {
                UIImage *img = [self captureWithView:self.container];
//                UIImage *img = [self imageWithUIView:self.container];
                UIImageWriteToSavedPhotosAlbum(img, NULL, NULL, NULL);

            } else {
            
            }
        });
    }];
}

- (UIImage *)imageWithUIView:(UIView *)view{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    // [view.layer drawInContext:currnetContext];
    [view.layer renderInContext:currnetContext];
    // 从当前context中创建一个改变大小后的图片
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)captureWithView:(UIView *)view {
    // 1.开启上下文
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 3);
     
    // 2.将控制器view的layer渲染到上下文
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
     
    // 3.取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
     
    // 4.结束上下文
    UIGraphicsEndImageContext();
     
    return newImage;
}
@end

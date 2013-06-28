//
//  MGViewController.m
//  melanogenesis
//
//  Created by Aleksey Orlov on 6/28/13.
//  Copyright (c) 2013 Aleksey Orlov. All rights reserved.
//

#import "MGViewController.h"
#import "opencv2/opencv.hpp"
#import "opencv2/highgui/highgui.hpp"
#import "opencv2/imgproc/imgproc.hpp"

#import <stdio.h>
#import <stdlib.h>

using namespace cv;

@interface MGViewController (){
    
    int col, row;
    UIImage* img;
    cv::Mat image;

}

- (UIImage *)imageWithCVMat:(const Mat&)cvMat;

@end



@implementation MGViewController

@synthesize imageView;
@synthesize btn;

- (UIImage *)imageWithCVMat:(const cv::Mat&)cvMat{
    NSData *data = [NSData dataWithBytes:cvMat.data length:cvMat.elemSize() * cvMat.total()];
    
    CGColorSpaceRef colorSpace;
    
    if (cvMat.elemSize() == 1) {
        colorSpace = CGColorSpaceCreateDeviceGray();
    } else {
        colorSpace = CGColorSpaceCreateDeviceRGB();
    }
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    
    CGImageRef imageRef = CGImageCreate(cvMat.cols,                                     // Width
                                        cvMat.rows,                                     // Height
                                        8,                                              // Bits per component
                                        8 * cvMat.elemSize(),                           // Bits per pixel
                                        cvMat.step[0],                                  // Bytes per row
                                        colorSpace,                                     // Colorspace
                                        kCGImageAlphaNone | kCGBitmapByteOrderDefault,  // Bitmap info flags
                                        provider,                                       // CGDataProviderRef
                                        NULL,                                           // Decode
                                        false,                                          // Should interpolate
                                        kCGRenderingIntentDefault);                     // Intent
    
    UIImage *imageDst = [[UIImage alloc] initWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    return imageDst;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
       
    [super viewDidLoad];
    
    image.create(500, 500, CV_8UC3);
    //image = 0;
    
    img = [[UIImage alloc] init];
    img = [self imageWithCVMat:image];
    
    //    int x = 0;
    //    int y = 0;
    //    int row = 0;
    //    int col = 0;
    
    col = 200;
    row = 200;

    
    
    [self.imageView setImage:img];
    
//    for (;;){
//    
//        x++;
//        y++;
//        
//        col++; row++;
//        
//        if (col > image.cols-1) col = col - image.cols;
//        if (row > image.rows-1) row = row - image.rows;
//        
//        if (col < 0) col = col + image.cols;
//        if (row < 0) row = row + image.rows;
//        
//        
//        image.data[row * image.step1() + col*image.channels() + 0] = 250;
//        
//        
//        [self.imageView setImage:img];
//    }
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnClick:(id)sender {
    
    
    //col = (int)(image.cols *  rand()/RAND_MAX);
    //row = (int)(image.rows *  rand()/RAND_MAX);
    
    //col = + 20;
    //row = + 50;
    
    
    for (int i=0; i<100; i++){
        col += 10;
        row = 200;
        
        
        if (col > image.cols-1) col = col - image.cols;
        if (row > image.rows-1) row = row - image.rows;
        
        if (col < 0) col = col + image.cols;
        if (row < 0) row = row + image.rows;
        
        
        //image.data[row * image.step1() + col*image.channels() + 0] = 250;
        
        cv::circle(image, cv::Point(col, row), 50, cv::Scalar(200,200,200));
        
        img = [self imageWithCVMat:image];

        
        [self.imageView setImage:img];
    }

    
}
@end

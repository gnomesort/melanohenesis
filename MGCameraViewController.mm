//
//  MGCameraViewController.m
//  melanogenesis
//
//  Created by Aleksey Orlov on 6/28/13.
//  Copyright (c) 2013 Aleksey Orlov. All rights reserved.
//

#import "MGCameraViewController.h"

#import "opencv2/opencv.hpp"
#import "opencv2/highgui/highgui.hpp"
#import "opencv2/imgproc/imgproc.hpp"

#import <stdio.h>

using namespace cv;

@interface MGCameraViewController (){
    
    
    
    int iWidth;
	int iHeight;
    
	int iRows;
	int iCols;
    
	double fWidth;
	double fHeight;
    
	double ratio;
    
    double dt;
	double kx;
	double ky;
    double t;
    
	Mat mask;
    Mat mask_f;
    Mat img;
    Mat img_dst;
    
}

@property (retain, nonatomic) CvVideoCamera * videoCamera;

-(void)initMG;


@end



@implementation MGCameraViewController


@synthesize videoCamera;
@synthesize imageView;
@synthesize tag;


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
    
    self.videoCamera = [[CvVideoCamera alloc] initWithParentView:imageView];
    self.videoCamera.delegate = self;
    
    self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;
    self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset352x288;
    self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self.videoCamera.defaultFPS = 30;
    self.videoCamera.grayscaleMode = NO;

    cv::Size frameSize;
    frameSize.height = videoCamera.imageHeight;
    frameSize.width = videoCamera.imageWidth;
    
    frameSize.height = 352;
    frameSize.width = 288;
    

    img.create(frameSize, CV_8UC3);

    [self initMG];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startButtonClick:(id)sender {
    
    [self.videoCamera start];
}

-(IBAction)viewDidDisappear:(BOOL)animated{
    
    [self.videoCamera stop];
    
}


-(void)initMG{

    iWidth = img.size().width;
	iHeight = img.size().height;
    
	iRows = img.rows;
	iCols = img.cols;
    
    
    
	img_dst.create(iRows, iCols, CV_8UC1);

    mask.create(iRows, iCols, CV_32FC1);

    
	fWidth  = 1.0*(double)iWidth/(double)iHeight;
	fHeight = 1.0;
    
	//ratio = (double)iHeight/fHeight;
	ratio = (double)fHeight/iHeight;
	
    
	t = 0;
    
	//imshow("image dst", image_dst);
	//waitKey();
    
	int key;
    dt = 0.3;
	kx = 40.0;
	ky = 1;
    
}

- (void)processImage:(Mat&)image{
    
    t +=dt;
    
    double x0;
    double y0;
    double x1;
    double y1;
    double x2;
    double y2;
    
    
    double r0, r1, r2;
    double fi0, fi1, fi2;
    

    //double res = cos(x * kx)*sin(y * ky + t);
    //double res = cos(r * kx)*sin(fi * ky);
    double res0, res1, res2, res;
    
    for (int col = 0; col < iWidth; col++)
        for (int row = 0; row < iHeight; row++)
        {
            x0 = ratio * (col - 4*iWidth/5);
            y0 = ratio * (row - 2*iHeight/3);
            
            x1 = ratio * (col - iWidth/5);
            y1 = ratio * (row - iHeight/3);
            
            x2 = ratio * (col - 4*iWidth/5);
            y2 = ratio * (row - iHeight/5);
            
            
            r0 = sqrt(x0*x0 + y0*y0);
            fi0 = atan2(x0,y0);
            
            r1 = sqrt(x1*x1 + y1*y1);
            fi1 = atan2(x1, y1);
            
//            r2 = sqrt(x2*x2 + y2*y2);
//            fi2 = atan2(x2, y2);
            
            
            
            //res = cos(x * kx)*sin(y * ky + t);
            //res = cos(r * kx)*sin(fi * ky);
            res0 = cos(fi0 * ky - t*1 + r0*kx*1.0) * sin(r0 * kx * 2.76 + CV_PI/2.0);
            res1 = cos(fi1 * ky - t*1.7 + r1*kx*1.3) * sin(r1 * kx * 0.23 + CV_PI/2.0);
            //res2 = cos(fi2 * ky - t*0.1 + r2*kx*3.3) * sin(r2 * kx * 1.23 + CV_PI/2.0);
            
            
            res = (res0 > res1 ? res0 : res1);
            res = (res0 + res1)/2;
            //res = (res > res2 ? res : res2);
            
            //res = res0*res1;
            
            //res = x0 + y0 + t;
            
            //double res = cos(r * kx + fi * ky - t);
            //double res = cos(r * kx + fi * ky*t);
            
            img_dst.data[ row * img_dst.step1() + col * img_dst.channels()] = (int)(res * 128) + 128;
            //mask_f.data[ row * mask_f.step1() + col * mask_f.channels()] = res * 0.5 + 0.5;
            

            if ([self tag] == 1){
//                image.data[ (int)(row * (double)image.rows/(double)iHeight) * image.step1() + (int)(col * (double)image.cols/(double)iWidth) * image.channels() + 0] *= (res*0.5 + 0.5);
//                image.data[ (row * image.rows/iHeight) * image.step1() + (col * image.cols/iWidth) * image.channels() + 1] *= (res*0.5 + 0.5);
//                image.data[ (row * image.rows/iHeight) * image.step1() + (col * image.cols/iWidth) * image.channels() + 2] *= (res*0.5 + 0.5);
                
                image.data[ (row ) * image.step1() + (col) * image.channels() + 0] *= (res*0.5 + 0.5);
                image.data[ (row ) * image.step1() + (col) * image.channels() + 1] *= (res*0.5 + 0.5);
                image.data[ (row ) * image.step1() + (col) * image.channels() + 2] *= (res*0.5 + 0.5);

            }
            
            

        }
    
    //img_dst = img_dst > 128;
    
    
    if ([self tag] == 2)
    image = img_dst.clone();
    
}
    
@end

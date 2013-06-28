//
//  MGViewController.h
//  melanogenesis
//
//  Created by Aleksey Orlov on 6/28/13.
//  Copyright (c) 2013 Aleksey Orlov. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <opencv2/highgui/cap_ios.h>

//#import "opencv2/opencv.hpp"
//#import "opencv2/highgui/highgui.hpp"
//#import "opencv2/imgproc/imgproc.hpp"

//using namespace cv;
@interface MGViewController : UIViewController




@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *btn;


- (IBAction)btnClick:(id)sender;

@end

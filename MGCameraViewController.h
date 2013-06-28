//
//  MGCameraViewController.h
//  melanogenesis
//
//  Created by Aleksey Orlov on 6/28/13.
//  Copyright (c) 2013 Aleksey Orlov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <opencv2/highgui/cap_ios.h>


@interface MGCameraViewController : UIViewController<CvVideoCameraDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property(nonatomic) int tag;

- (IBAction)startButtonClick:(id)sender;

@end

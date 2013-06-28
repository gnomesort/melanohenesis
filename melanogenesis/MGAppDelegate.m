//
//  MGAppDelegate.m
//  melanogenesis
//
//  Created by Aleksey Orlov on 6/28/13.
//  Copyright (c) 2013 Aleksey Orlov. All rights reserved.
//

#import "MGAppDelegate.h"
#import "MGViewController.h"
#import "MGCameraViewController.h"

@implementation MGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    
    MGViewController* MGView1 = [[MGViewController alloc] init];
    MGCameraViewController* cameraView = [[MGCameraViewController alloc] init];
    MGCameraViewController* cameraView2 = [[MGCameraViewController alloc] init];

    
    
    [MGView1.tabBarController setTitle:@"View1"];
    [cameraView.tabBarController setTitle:@"view2"];
    [cameraView2.tabBarController setTitle:@"view2"];
    
    
    
    
    [cameraView setTag:1];
    [cameraView2 setTag:2];
    
    
    
        
    
    
    //UIPinchGestureRecognizer * pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:camVC1 action:@selector(pinchRec)];
    //[[camVC4 view] addGestureRecognizer: pinchRecognizer];
    
    
    UITabBarController * tbc = [[UITabBarController alloc] init];
    
    
    [tbc setViewControllers:[NSArray arrayWithObjects:MGView1, cameraView, cameraView2, nil]];
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self.window setRootViewController: tbc];
    return YES;

}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

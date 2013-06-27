//
//  MGModelController.h
//  melanogenesis
//
//  Created by Aleksey Orlov on 6/28/13.
//  Copyright (c) 2013 Aleksey Orlov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MGDataViewController;

@interface MGModelController : NSObject <UIPageViewControllerDataSource>

- (MGDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(MGDataViewController *)viewController;

@end

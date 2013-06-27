//
//  MGDataViewController.h
//  melanogenesis
//
//  Created by Aleksey Orlov on 6/28/13.
//  Copyright (c) 2013 Aleksey Orlov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGDataViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) id dataObject;

@end

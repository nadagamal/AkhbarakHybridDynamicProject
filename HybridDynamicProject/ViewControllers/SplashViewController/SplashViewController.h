//
//  SplashViewController.h
//  almasryalyoum
//
//  Created by MohamedMansour on 10/23/14.
//  Copyright (c) 2014 Sarmady.net. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SplashViewController : UIViewController<UIAlertViewDelegate>
@property(nonatomic,retain) IBOutlet UIButton *retryBtn;
@property (assign,nonatomic) BOOL isFromAppDelegate;
@property (weak, nonatomic) IBOutlet UIImageView *sponserImg;

@end

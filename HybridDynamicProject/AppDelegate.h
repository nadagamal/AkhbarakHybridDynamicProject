//
//  AppDelegate.h
//  hrm
//
//  Created by MohamedMansour on 3/24/13.
//  Copyright (c) 2013 MohamedMansour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshViewController.h"
#import "SplashViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,RefreshDelegate>


@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property(nonatomic,retain) NSString *pushedUrl;
@property(nonatomic,retain) RefreshViewController *refreshViewController;
@property(nonatomic,assign)BOOL isFirstLoad;
@property(nonatomic,strong) SplashViewController *splashViewController;

@end

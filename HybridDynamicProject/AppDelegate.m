//
//  AppDelegate.m
//  hrm
//
//  Created by MohamedMansour on 3/24/13.
//  Copyright (c) 2013 MohamedMansour. All rights reserved.
//

#import "AppDelegate.h"

#import <Pushbots/Pushbots.h>
#import "PushWebViewController.h"
#import "AppInfo.h"
#import "Global.h"
#import "Urls.h"
#import <Netmera/Netmera.h>

@implementation AppDelegate
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"New Alert !" message:error.description delegate:nil cancelButtonTitle:@"Thanks !" otherButtonTitles: @"Open",nil];
    // [message show];
}
-(void)handelNoti:(NSDictionary *)userInfo{
    NSString* title = [[userInfo valueForKey:@"aps"] objectForKey:@"alert"];
    NSString *url=[userInfo objectForKey:@"url" ];
    if ( UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad )
    {
        for (Urls *urlPair in [Global getInstance].appInfo.urls) {
            if ([url hasPrefix:urlPair.durl]) {
                url= [url stringByReplacingOccurrencesOfString:urlPair.durl withString:urlPair.murl];
            }
        }
    }
    if (url!=nil) {
        
        self.pushedUrl=url;
        
        if(!_isFirstLoad)
        {
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:title message:@"" delegate:self cancelButtonTitle:@"الغاء" otherButtonTitles: @"عرض",nil];
            message.tag=3;
            [message show];
        }
        else
        {
            _isFirstLoad=NO;
            PushWebViewController *controller = [[PushWebViewController alloc] initWithType:self.pushedUrl];
            
            [self.navigationController   pushViewController:controller animated:YES];
            
        }
        
    }
    
    
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
    [self handelNoti:userInfo];
}
- (void)didReceivePush:(NMPushObject*)push appState:(NMAppState)state fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
    
}
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    [[NSUserDefaults standardUserDefaults] setObject:deviceToken forKey:@"PushbotsDDId"];
    
    NSString* PushbotsReg = [[NSUserDefaults standardUserDefaults] objectForKey:@"PushbotsReg"];
    if (PushbotsReg==nil||[PushbotsReg isEqualToString:@"YES"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"PushbotsReg"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        
    }
    else{
        [NMPushManager unregisterWithCompletionHandler:^(BOOL deviceDidUnregister, NSError *error) {
            if (!error)
                NSLog(@"The device is unregistered successfully.");
            else
                NSLog(@"Error occurred. Reason: %@", error.localizedDescription);
        }];
        
        
    }
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if(buttonIndex==1)
    {
        PushWebViewController *controller = [[PushWebViewController alloc] initWithType:self.pushedUrl];
        
        [self.navigationController   pushViewController:controller animated:YES];
    }
    
    // set Badge to 0
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    // reset badge on the server
    
    
}
- (BOOL)shouldPresentRichPush:(NMRichPushObject*)richPush
{
    PushWebViewController *controller = [[PushWebViewController alloc] initWithType:self.pushedUrl];
    
    [self.navigationController   pushViewController:controller animated:YES];
    
    return YES;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    
    [Netmera setApiKey:@"ZGoweEpuVTlOVFEyTVdSa05qaGxOR0l3WldNNFpXRTROV1ZoTXpGaUpuSTlNQ1poUFdGcmFHSmhjbUZySmc="];
    
    
    
    self.window.rootViewController = self.navigationController;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    [self.window makeKeyAndVisible];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    
    // reset badge on the server
    //This check is needed if your application supports iOS 7 or before.
    if([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        //FIRST CATEGORY (Accept/Decline Button Set)
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"AcceptButton";
        action1.title = @"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];
        action2.identifier = @"DeclineButton";
        action2.title = @"Decline";
        action2.activationMode = UIUserNotificationActivationModeForeground;
        //To show a destructive button.
        action2.destructive = YES;
        
        UIMutableUserNotificationCategory *acceptDecline = [[UIMutableUserNotificationCategory alloc] init];
        //This identifier string will be visible in Netmera panel.
        acceptDecline.identifier = @"AcceptDeclineAction";
        
        //Setting actions for UIUserNotificationActionContextMinimal is enough. SDK will automatically add related action for UIUserNotificationActionContextDefault also.
        //PS: Netmera currently NOT supports having more than two actions. So, you can NOT use different action sets for different contexts.
        [acceptDecline setActions:@[action1, action2] forContext:UIUserNotificationActionContextMinimal];
        
        //SECOND CATEGORY (Reply/Mark As Read Button Set)
        UIMutableUserNotificationAction *action3 = [[UIMutableUserNotificationAction alloc] init];
        action3.identifier = @"ReplyButton";
        action3.title = @"Reply";
        action3.activationMode = UIUserNotificationActivationModeForeground;
        
        UIMutableUserNotificationAction *action4 = [[UIMutableUserNotificationAction alloc] init];
        action4.identifier = @"MarkAsReadButton";
        action4.title = @"Mark As Read";
        //This tells that application will not be opened when Mark As Read button is selected.
        //It will only wake the application in background mode.
        action4.activationMode = UIUserNotificationActivationModeBackground;
        
        UIMutableUserNotificationCategory *mailCategory = [[UIMutableUserNotificationCategory alloc] init];
        mailCategory.identifier = @"MailReplyAction";
        [mailCategory setActions:@[action4, action3] forContext:UIUserNotificationActionContextMinimal];
        
        //Registers the device to related interactive notification categories.
        [NMPushManager setUserNotificationCategories:[NSSet setWithObjects:acceptDecline, mailCategory, nil]];
    }
    // add splash screen
    _splashViewController = [[SplashViewController alloc] initWithNibName:@"SplashViewController" bundle:nil];
    //_splashViewController.view.frame=[[UIScreen mainScreen]bounds];
    _splashViewController.isFromAppDelegate=YES;
    [self.window addSubview:_splashViewController.view];
    [self.window makeKeyAndVisible];
    [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(onSlashScreenDone) userInfo:nil repeats:NO];
    NSDictionary * userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if(userInfo) {
        // Notification Message
        self.isFirstLoad=YES;
        [self handelNoti:userInfo];
        
    }
    
    
    return YES;
}
-(void)onReceivePushNotification:(NSDictionary *) pushDict andPayload:(NSDictionary *)payload {
    [payload valueForKey:@"title"];
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"New Alert !" message:[pushDict valueForKey:@"alert"] delegate:self cancelButtonTitle:@"Thanks !" otherButtonTitles: @"Open",nil];
    [message show];
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
- (void)handleActionForPush:(NMPushObject *)push appState:(NMAppState)state completionHandler:(void (^)())completionHandler
{
    //Check action identifier
    
    self.pushedUrl=[push.actionParams objectForKey:@"url"];
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"PUSH"];
    [[NSUserDefaults standardUserDefaults]setObject:self.pushedUrl forKey:@"URL"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    if([push.actionIdentifier isEqualToString:@"AcceptButton"])
    {
        //TODO: Show information about accepted content.
        
    }
    else if([push.actionIdentifier isEqualToString:@"DeclineButton"])
    {
        //TODO: Send decline request to server.
        //TODO: Show information about accepted content.
        // PushWebViewController *controller = [[PushWebViewController alloc] initWithType:self.pushedUrl];
        
        //[self.navigationController   pushViewController:controller animated:YES];
    }
    else if([push.actionIdentifier isEqualToString:@"ReplyButton"])
    {
        //TODO: Open mail reply screen.
    }
    else if([push.actionIdentifier isEqualToString:@"MarkAsReadButton"])
    {
        //TODO: Send mark as read request to server.
    }
    
    //Here you could get parameters related to selected action which are set in Netmera panel using push.actionParams property
    
    NSLog(@"Action Parameters : %@",[push.actionParams objectForKey:@"url"]);
    
    //You should always call completionHandler when you are finished.
    //  self.navigationController.visibleViewController=self.window.rootViewController;
    
    // SplashViewController * splashScreen=[[SplashViewController alloc]initWithNibName:@"SplashViewController" bundle:nil];
    //self.navigationController=[[UINavigationController alloc]initWithRootViewController:splashScreen];
    //self.window.rootViewController=self.navigationController;
    
    //  PushWebViewController *controller = [[PushWebViewController alloc] initWithNibName:@"PushWebViewController" bundle:nil];
    // self.window.rootViewController=controller;
    
    //   [controller view];
    //[self.navigationController   pushViewController:controller animated:YES];
    completionHandler();
    
    
    
    
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    application.applicationIconBadgeNumber = 0;
    application.applicationIconBadgeNumber = 0;
    if([[NSUserDefaults standardUserDefaults]boolForKey:@"PUSH"])
    {
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"PUSH"];
        PushWebViewController *controller = [[PushWebViewController alloc] initWithNibName:@"PushWebViewController" bundle:nil];
        controller.url=[[NSUserDefaults standardUserDefaults]objectForKey:@"URL"];
        [self.navigationController.view addSubview:controller.view];
        [self.navigationController   pushViewController:controller animated:YES];
        
    }
    NSArray *popupList = [NMPopupManager getTriggeredPopups];
    for (NMPopupObject *popup  in popupList ) {
        [NMPopupManager presentPopup:popup];
    }
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}
-(void)onSlashScreenDone{
    [_splashViewController.view removeFromSuperview];
    [_window addSubview:[_navigationController view]];
    [_window makeKeyAndVisible];
}
- (BOOL)shouldPresentInteractivePushInForeground:(NMPushObject*)push
{
    return YES;
}
- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

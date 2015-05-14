//
//  WebViewController.h
//  FiZQuran
//
//  Created by MohamedMansour on 8/23/13.
//  Copyright (c) 2013 MohamedMansour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshViewController.h"
#import "Reachability.h"
@interface WebViewController : UIViewController<UIWebViewDelegate,RefreshDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic,retain) NSString *url;
@property(nonatomic,assign) BOOL finished ;
@property(nonatomic,assign) int noOfRequests ;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView * activityIndicator;
@property(nonatomic,retain) RefreshViewController *refreshViewController;
@property(nonatomic,retain)  Reachability *reachability ;
@property(nonatomic,retain) UIRefreshControl *refreshControl;

- (IBAction)back:(id)sender;
- (id)initWithType:(NSString*) url;
-(IBAction)goForward:(id)sender;
-(IBAction)stop:(id)sender;
-(IBAction)Refresh:(id)sender;
-(void)loadNotificationUrl:(NSString*)url;
@end

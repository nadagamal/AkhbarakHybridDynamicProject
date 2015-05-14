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
@interface PushWebViewController : UIViewController<UIWebViewDelegate,RefreshDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *headerImg;

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView * activityIndicator;

@property(nonatomic,retain) RefreshViewController *refreshViewController;
@property(nonatomic,retain)  Reachability *reachability ;

@property(nonatomic,retain) NSString *url;
- (IBAction)back:(id)sender;
- (id)initWithType:(NSString*) url;
@end

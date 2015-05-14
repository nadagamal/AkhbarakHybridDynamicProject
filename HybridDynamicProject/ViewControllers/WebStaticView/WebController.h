//
//  WebController.h
//  New-Muslim
//
//  Created by MohamedMansour on 2/12/13.
//
//

#import <UIKit/UIKit.h>
#import "RefreshViewController.h"
#import "Reachability.h"

@interface WebController : UIViewController<UIWebViewDelegate,RefreshDelegate>

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

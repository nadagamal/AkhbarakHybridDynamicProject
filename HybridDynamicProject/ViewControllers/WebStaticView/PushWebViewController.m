//
//  WebViewController.m
//  FiZQuran
//
//  Created by MohamedMansour on 8/23/13.
//  Copyright (c) 2013 MohamedMansour. All rights reserved.
//

#import "PushWebViewController.h"

@interface PushWebViewController ()

@end

@implementation PushWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithType:(NSString*) url{
    self=[super init];
    if (self) {
        self.url=url;
    }
    
    return self;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.webView.backgroundColor = [UIColor clearColor];
   
    
    self.webView.opaque=NO;
  //  [self.webView setScalesPageToFit:YES];
    [self.webView sizeToFit];
    
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    // Do any additional setup after loading the view from its nib.
   
    self.refreshViewController=[[RefreshViewController alloc] init];
    self.refreshViewController.delegate=self;
     [self.view addSubview:self.refreshViewController.view];
    
     [self checkInternetAndLoad];
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)checkInternetAndLoad{
    if (!self.reachability)
     self.reachability = [Reachability reachabilityForInternetConnection];
    
    NetworkStatus internetStatus = [self.reachability currentReachabilityStatus];
    if (internetStatus == NotReachable) {
        //my web-dependent code
        self.refreshViewController.view.hidden=NO;
        
    }
    else {
        self.refreshViewController.view.hidden=YES;
        NSURLRequest *request=[NSURLRequest requestWithURL:
                               [NSURL URLWithString:
                                [self.url stringByAddingPercentEscapesUsingEncoding:
                                 NSUTF8StringEncoding]]];
        [self.webView loadRequest:request];

    }
}
-(void)offlineViewDidRefreshButtonClicked{
    [self checkInternetAndLoad];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    [self.activityIndicator startAnimating];
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.activityIndicator stopAnimating];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidUnload {
    [self setWebView:nil];
    [self setHeaderImg:nil];
    [super viewDidUnload];
}
@end

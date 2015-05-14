//
//  WebViewController.m
//  FiZQuran
//
//  Created by MohamedMansour on 8/23/13.
//  Copyright (c) 2013 MohamedMansour. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController
@synthesize webView;
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
-(void)loadNotificationUrl:(NSString*)url{
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [webView loadRequest:request];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.finished=NO;
    self.noOfRequests=0;
    self.refreshViewController=[[RefreshViewController alloc] init];
    self.refreshViewController.delegate=self;
    [self.view addSubview:self.refreshViewController.view];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:nil action:@selector(updateArray:) forControlEvents:UIControlEventValueChanged];
    [webView.scrollView addSubview:self.refreshControl];
    
   [self checkInternetAndLoad];
   //[webView setScalesPageToFit:NO];
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void) updateArray :(UIRefreshControl *)sender {
    
    [webView reload];
     [self.refreshControl endRefreshing];
    
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
        NSURLRequest *request=[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.url]];
        [webView loadRequest:request];
        
    }
}
-(void)offlineViewDidRefreshButtonClicked{
    [self checkInternetAndLoad];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)goBack:(id)sender{
    if (webView.canGoBack == YES)
        [webView goBack]; // if webView.canGoBack == YES;
    
    
    
    
    
}
-(IBAction)goTOHome:(id)sender{
    if (webView.canGoBack == YES)
        [webView goBack]; // if webView.canGoBack == YES;
    
    
    
    
    
}
-(IBAction)goForward:(id)sender{
    if (webView.canGoForward == YES)
        
        [webView  goForward]; // if webView.canGoForward == YES;
    
}
-(IBAction)stop:(id)sender{
    
    
    [webView  stopLoading]; // if webView.canGoForward == YES;
    
}
-(IBAction)Refresh:(id)sender{
    
    
    [webView  reload]; // if webView.canGoForward == YES;
    
}
-(void)webViewDidFinishLoad:(UIWebView *)wwebView{
    self.noOfRequests--;
    
    //[webView sizeToFit];
    //    [webView stringByEvaluatingJavaScriptFromString:@"{ var a = document.getElementsByTagName(\"a\");  for (var i=0; i<a.length; i++)  { a[i].target = \"_self\"; }	 }"];
    //	[webView stringByEvaluatingJavaScriptFromString:@"window.open = function( inurl, blah, blah2 ) {  document.location = inurl; }"];
    
    
    [self.activityIndicator stopAnimating];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.noOfRequests--;
    [self.activityIndicator stopAnimating];
    
}
#pragma mark webView delegate
- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    [self.activityIndicator startAnimating];
    //NSString *baseUrl=@"almasryalyoum.com";
    
    //||
    NSString *urlToOpen= [request.URL host];
    if (self.finished) {
        [[UIApplication sharedApplication] openURL:request.URL];
        self.finished=NO;
        [self.activityIndicator stopAnimating];
        return NO;
    }
    if(!([[request.URL absoluteString] rangeOfString:@"/aclk?"].location == NSNotFound)){
        self.finished=YES;
        return YES;
    }
    
    if(navigationType==UIWebViewNavigationTypeLinkClicked&&[urlToOpen rangeOfString:@"akhbarak.net"].location == NSNotFound&&[urlToOpen rangeOfString:@"akhbarak.net"].location == NSNotFound){
        
        [[UIApplication sharedApplication] openURL:request.URL];
        [self.activityIndicator stopAnimating];
        return NO ;
    }
    
    if(navigationType==UIWebViewNavigationTypeOther&&(!([[request.URL absoluteString] rangeOfString:@"www.addthis.com/bookmark.php"].location == NSNotFound)||!([[request.URL absoluteString] rangeOfString:@"facebook.com/sharer.php"].location == NSNotFound))
       
       ){
        
        [[UIApplication sharedApplication] openURL:request.URL];
        [self.activityIndicator stopAnimating];
        return NO ;
    }
    
    
    
    return YES;
    
    
    
    
}
@end

////
////  HomeViewController.m
////  Doom
////
////  Created by MohamedMansour on 7/1/14.
////  Copyright (c) 2014 Sarmady.net. All rights reserved.
////
//
//#import "HomeViewController.h"
//#import "AppUrls.h"
//#import "Global.h"
//#import "UIButton+WebCache.h"
//#import "Icons.h"
//#import "PushWebViewController.h"
//#import "AppDelegate.h"
//@interface HomeViewController ()
//
//@end
//
//@implementation HomeViewController
//@synthesize screenWidth,ipadscreenWidth;
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
//- (void) receiveTestNotification:(NSNotification *) notification
//{
//    // [notification name] should always be @"TestNotification"
//    // unless you use this method for observation of other notifications
//    // as well.
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    //[self.navigationController pushViewController:[[PushWebViewController alloc] initWithType:appDelegate.pushedUrl] animated:YES];
//    [self homeBtnTaped:nil];
//    [self.homeController  loadNotificationUrl:appDelegate.pushedUrl];
//
//}
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    self.navigationController.navigationBar.hidden=YES;
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(receiveTestNotification:)
//                                                 name:@"TestNotification"
//                                               object:nil];
//    
//    NSString *ipadSufix=@"";
//    
//   
//    
//    
//    screenWidth=320;
//    ipadscreenWidth=320;
//   //NSString *urlHome=@"http://m.almasryalyoum.com/";
//    NSString *urlHome=[Global getInstance].appUrls.newsMobileUrl;
//    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
//        urlHome=[Global getInstance].appUrls.newsWebUrl;
//        //urlHome=@"http://www.almasryalyoum.com/";
//        ipadscreenWidth=self.view.frame.size.width;
//        screenWidth=self.view.frame.size.width;
//        ipadSufix=@"@2x~ipad";
//    }
//    if ([Global getInstance].appUrls!=nil) {
//        
//    NSString *homeImgUrl=[NSString stringWithFormat:@"%@%@%@.png",[Global getInstance].appUrls.icons.imgsBaseUrl,[Global getInstance].appUrls.icons.news,ipadSufix];
//    NSString *homeImgUrlActive=[NSString stringWithFormat:@"%@%@%@.png",[Global getInstance].appUrls.icons.imgsBaseUrl,[Global getInstance].appUrls.icons.newsActive,ipadSufix];
//    
//    NSString *shareImgUrl=[NSString stringWithFormat:@"%@%@%@.png",[Global getInstance].appUrls.icons.imgsBaseUrl,[Global getInstance].appUrls.icons.sendImage,ipadSufix];
//    NSString *shareImgUrlActive=[NSString stringWithFormat:@"%@%@%@.png",[Global getInstance].appUrls.icons.imgsBaseUrl,[Global getInstance].appUrls.icons.sendImageActive,ipadSufix];
//    
//    
//    NSString *settingImgUrl=[NSString stringWithFormat:@"%@%@%@.png",[Global getInstance].appUrls.icons.imgsBaseUrl,[Global getInstance].appUrls.icons.settings,ipadSufix];
//    NSString *settingImgUrlActive=[NSString stringWithFormat:@"%@%@%@.png",[Global getInstance].appUrls.icons.imgsBaseUrl,[Global getInstance].appUrls.icons.settingsActive,ipadSufix];
//    
//    NSString *aboutImgUrl=[NSString stringWithFormat:@"%@%@%@.png",[Global getInstance].appUrls.icons.imgsBaseUrl,[Global getInstance].appUrls.icons.about,ipadSufix];
//    NSString *aboutImgUrlActive=[NSString stringWithFormat:@"%@%@%@.png",[Global getInstance].appUrls.icons.imgsBaseUrl,[Global getInstance].appUrls.icons.aboutActive,ipadSufix];
//    
//    
//    
//    
//    [self.homeBtn setImageWithURL:[NSURL URLWithString:homeImgUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%@.png",@"news",ipadSufix]]];
//    [self.homeBtn setImageWithURL:[NSURL URLWithString:homeImgUrlActive] forState:UIControlStateSelected placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%@.png",@"news_active",ipadSufix]]];
//    
//    [self.shareBtn setImageWithURL:[NSURL URLWithString:shareImgUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%@.png",@"videos",ipadSufix]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
//        NSLog(@"%@",error.description);
//    }];
//    [self.shareBtn setImageWithURL:[NSURL URLWithString:shareImgUrlActive] forState:UIControlStateSelected placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%@.png",@"videos_active",ipadSufix]]];
//    
//    [self.settingBtn setImageWithURL:[NSURL URLWithString:settingImgUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%@.png",@"settings",ipadSufix]]];
//    [self.settingBtn setImageWithURL:[NSURL URLWithString:settingImgUrlActive] forState:UIControlStateSelected placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%@.png",@"settings_active",ipadSufix]]];
//    
//    [self.aboutBtn setImageWithURL:[NSURL URLWithString:aboutImgUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%@.png",@"about",ipadSufix]]];
//    [self.aboutBtn setImageWithURL:[NSURL URLWithString:aboutImgUrlActive] forState:UIControlStateSelected placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@%@.png",@"about_active",ipadSufix]]];
//    
//    }
//    
//    
//    self.homeController=[[WebController alloc] initWithType:urlHome];
//    self.homeController.view.frame=CGRectMake(3*screenWidth, 0, ipadscreenWidth, self.scrollView.frame.size.height);
//    [self.scrollView addSubview:self.homeController.view];
//    
//    NSString *shareurl=[Global getInstance].appUrls.sendImageUrl;
//   if ([[UIDevice currentDevice].systemVersion floatValue]<6.0) {
//       shareurl=[Global getInstance].appUrls.sendImageMailtoUrl;
//    }
//    self.shareViewController=[[WebViewController alloc] initWithType:shareurl];
//    self.shareViewController.view.frame=CGRectMake(2*screenWidth, 0, ipadscreenWidth, self.scrollView.frame.size.height);
//    [self.scrollView addSubview:self.shareViewController.view];
//    
//    self.settingViewController=[[SettingViewController alloc] init];
//    self.settingViewController.view.frame=CGRectMake(1*screenWidth, 0, ipadscreenWidth, self.scrollView.frame.size.height);
//    [self.scrollView addSubview:self.settingViewController.view];
//    
//    self.aboutViewController=[[WebViewController alloc] initWithType:[Global getInstance].appUrls.aboutUrl];
//    self.aboutViewController.view.frame=CGRectMake(0*screenWidth, 0, ipadscreenWidth, self.scrollView.frame.size.height);
//    [self.scrollView addSubview:self.aboutViewController.view];
//    
//    
//    
//    self.scrollView.contentSize=CGSizeMake(4*screenWidth, self.scrollView.frame.size.height);
//    self.scrollView.pagingEnabled=YES;
//    self.scrollView.contentOffset=CGPointMake(3*screenWidth, 0);
//    
//    self.homeBtn.selected=YES;
//    self.aboutBtn.selected=NO;
//    self.shareBtn.selected=NO;
//    self.settingBtn.selected=NO;
//   
//    // Do any additional setup after loading the view from its nib.
//}
//-(void)viewDidAppear:(BOOL)animated{
//   
//
//}
//-(IBAction)homeBtnTaped:(id)sender{
//    if(self.homeBtn.selected==YES){
//        [self.homeController.webView reload];
//    }
//    self.homeBtn.selected=YES;
//    self.aboutBtn.selected=NO;
//     self.shareBtn.selected=NO;
//     self.settingBtn.selected=NO;
//    [UIView animateWithDuration:0.5 animations:^{
//        self.scrollView.contentOffset=CGPointMake(screenWidth*3, 0);
//    }];
//    
//    
//    
//}
//-(IBAction)shareBtnTaped:(id)sender{
//    self.homeBtn.selected=NO;
//    self.aboutBtn.selected=NO;
//    self.shareBtn.selected=YES;
//    self.settingBtn.selected=NO;
//    [UIView animateWithDuration:0.5 animations:^{
//        self.scrollView.contentOffset=CGPointMake(screenWidth*2, 0);
//    }];
//
//}
//-(IBAction)settingBtnTaped:(id)sender{
//    self.homeBtn.selected=NO;
//    self.aboutBtn.selected=NO;
//    self.shareBtn.selected=NO;
//    self.settingBtn.selected=YES;
//    [UIView animateWithDuration:0.5 animations:^{
//        self.scrollView.contentOffset=CGPointMake(screenWidth*1, 0);
//    }];
//}
//-(IBAction)aboutBtnTaped:(id)sender{
//    self.homeBtn.selected=NO;
//    self.aboutBtn.selected=YES;
//    self.shareBtn.selected=NO;
//    self.settingBtn.selected=NO;
//    [UIView animateWithDuration:0.5 animations:^{
//        self.scrollView.contentOffset=CGPointMake(screenWidth*0, 0);
//    }];
//    
//}
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (scrollView.tag==201) {
//        
//        CGPoint offset = scrollView.contentOffset;
//        if (offset.x==0) {
//            self.homeBtn.selected=NO;
//            self.aboutBtn.selected=NO;
//            self.shareBtn.selected=NO;
//            self.settingBtn.selected=YES;
//            
//        }
//        else if (offset.x==screenWidth*1) {
//            self.homeBtn.selected=NO;
//            self.aboutBtn.selected=YES;
//            self.shareBtn.selected=NO;
//            self.settingBtn.selected=NO;
//            
//        }
//        
//        else if (offset.x==screenWidth*2) {
//            self.homeBtn.selected=NO;
//            self.aboutBtn.selected=NO;
//            self.shareBtn.selected=YES;
//            self.settingBtn.selected=NO;
//            
//        }
//        else if (offset.x==screenWidth*3) {
//            self.homeBtn.selected=YES;
//            self.aboutBtn.selected=NO;
//            self.shareBtn.selected=NO;
//            self.settingBtn.selected=NO;
//            
//        }
//    }
//}
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//@end

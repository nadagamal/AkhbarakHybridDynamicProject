//
//  SplashViewController.m
//  almasryalyoum
//
//  Created by MohamedMansour on 10/23/14.
//  Copyright (c) 2014 Sarmady.net. All rights reserved.
//

#import "SplashViewController.h"
#import "WebViewController.h"
#import "AppInfo.h"
#import "Global.h"
#import "TabsViewController.h"
#import "SFileHandler.h"
#import "App.h"
#import "Tabs.h"
#import <Netmera/NMPopupManager.h>
#import <Netmera/NMPopupObject.h>
#import <Netmera/NMPopupManager.h>
#import <Netmera/NMPopupObject.h>
#import "DataParser.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+WebCache.h"
#define   IsIphone5     ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)

@interface SplashViewController ()
{
    NSDictionary* parsedData;
    
}
@end

@implementation SplashViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [[[SDWebImageManager sharedManager] imageCache] clearDisk];
    [[[SDWebImageManager sharedManager] imageCache] clearMemory];
    if ([UIScreen mainScreen].bounds.size.height > 720.0)
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"1242-2208"]]];
    }
    else   if (IsIphone5)
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"640-1136"]]];
        
    }
    else if (IS_IPHONE_6)
    {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"750-1334-1"]]];
        
        
    }
    else{
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"640-960"]]];
        
    }
    [NMLocationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    [NMLocationManager setDistanceFilter:20.0];
    [NMLocationManager startLocationTracking];
    self.view.frame=[[UIScreen mainScreen]bounds];
    if(_isFromAppDelegate)
    {
        _isFromAppDelegate=NO;
        [self setSponserAds];
    }
    NSArray *popupList = [NMPopupManager getTriggeredPopups];
    for (NMPopupObject *popup  in popupList ) {
        [NMPopupManager presentPopup:popup];
    }
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden=YES;
    self.retryBtn.hidden=YES;
    [self LoadMetaData];
    // Do any additional setup after loading the view from its nib.
}
-(void)setSponserAds
{
    //  [self.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://static.akhbarak.net/resources/mobile_apps/akhbarak/appinfo_ios.json"]];
    //NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"www.ladyegypt.com/tour/safe"] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0];
    
    request.HTTPMethod = @"GET";
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[[NSOperationQueue alloc] init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                               if ([data length] > 0){
                                   parsedData = [DataParser parseData:(NSMutableData *)data];
                                   
                                   NSLog(@"%@",[[parsedData objectForKey:@"sponsor"]objectForKey:@"is_active"]);
                                   if([[[parsedData objectForKey:@"sponsor"]objectForKey:@"is_active"]intValue] ==1 )
                                   {
                                       [self.sponserImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/SponsorImages/iOS/splash_960.png",[ [parsedData objectForKey:@"sponsor"]objectForKey:@"imgs_base_url"]]]];
                                       
                                       // self.navigationController.navigationBar.hidden=YES;
                                       
                                       
                                       //  self.stripeImgView.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/MainSponsor/Splash_1136.png",[ [parsedData objectForKey:@"sponsor"]objectForKey:@"imgs_base_url"]]]]];
                                       
                                   }
                                   if([[[parsedData objectForKey:@"message"]objectForKey:@"is_active"]intValue] ==1 )
                                   {
                                       UIAlertView *message = [[UIAlertView alloc] initWithTitle:[[parsedData objectForKey:@"message"]objectForKey:@"msg"] message:nil delegate:self cancelButtonTitle:@"الغاء" otherButtonTitles: @"تنزيل التحديث",nil];
                                       message.tag=1;
                                       message.delegate=self;
                                       [message show];
                                   }
                                   
                                   
                                   
                                   
                               }
                               else {
                                   dispatch_async(dispatch_get_main_queue(),^{
                                       // SHOW_ALERT(@"", @"");
                                   });
                                   
                               }
                           }];
    
}
-(void)LoadMetaData{
    self.navigationController.navigationBar.hidden=YES;
    NSError *Cer;
    NSString *CAppUrlsString=[NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://api.filgoal.com/MobileAppResources/Amay/connection.json"] encoding:NSUTF8StringEncoding error:&Cer];
    if (CAppUrlsString!=nil) {
        
        NSDictionary *CJSON =
        [NSJSONSerialization JSONObjectWithData: [CAppUrlsString dataUsingEncoding:NSUTF8StringEncoding]
                                        options: NSJSONReadingMutableContainers
                                          error: &Cer];
        if ([[CJSON objectForKey:@"statusCode"] intValue] ==0) {
            
        }
        else{
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:[CJSON objectForKey:@"statusMessage"] message:nil delegate:nil cancelButtonTitle:@"موافق" otherButtonTitles:nil,nil];
            [message show];
            self.retryBtn.hidden=YES;
            return;
            
        }
    }
    else{
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"خطأ في الاتصال بالإنترنت ، رجاء التحقق من الإتصال بالإنترنت الخاص بك" message:nil delegate:self cancelButtonTitle:@"موافق" otherButtonTitles:@"حاول مرة أخري",nil];
        [message show];
        self.retryBtn.hidden=YES;
        return;
        
        
    }
    
    NSError *er;
    NSString *appUrlsString=[NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://static.akhbarak.net/resources/mobile_apps/akhbarak/appinfo_ios.json"] encoding:NSUTF8StringEncoding error:&er];
    if (appUrlsString!=nil) {
        
        NSDictionary *JSON =
        [NSJSONSerialization JSONObjectWithData: [appUrlsString dataUsingEncoding:NSUTF8StringEncoding]
                                        options: NSJSONReadingMutableContainers
                                          error: &er];
        AppInfo *appInfo=[AppInfo modelObjectWithDictionary:JSON];
        
        [Global getInstance].appInfo=appInfo;
        if( [Global getInstance].appInfo.tabs.count==1){
            Tabs *tab =  [[Global getInstance].appInfo.tabs objectAtIndex:0];
            [self.navigationController pushViewController:[[WebViewController alloc] initWithType:tab.tabMobileUrl] animated:NO];
        }
        else{
            NSString *folderName=@"IPhoneImages";
            NSString* imageVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"imgsVersion"];
            //First Time
            if (imageVersion==nil) {
                imageVersion=@"1";
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"imgsVersion"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [SFileHandler deleteFloder:folderName];
                
            }
            if (![imageVersion isEqualToString:[Global getInstance].appInfo.app.imgsVersion]) {
                [[NSUserDefaults standardUserDefaults] setObject:[Global getInstance].appInfo.app.imgsVersion forKey:@"imgsVersion"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [SFileHandler deleteFloder:folderName];
            }
            
            for (Tabs *tab in  [Global getInstance].appInfo.tabs) {
                [self CheckImageAndLoad:tab.tabImage];
                [self CheckImageAndLoad:tab.tabImageActive];
            }
            //[self.navigationController popViewControllerAnimated:NO];
            [self.navigationController pushViewController:[[TabsViewController alloc] init] animated:NO];
        }
    }
    else{
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"خطأ في الاتصال بالإنترنت ، رجاء التحقق من الإتصال بالإنترنت الخاص بك" message:nil delegate:self cancelButtonTitle:@"موافق" otherButtonTitles:@"حاول مرة أخري",nil];
        [message show];
        self.retryBtn.hidden=YES;
        return;
        
    }
    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==1) {
        if (buttonIndex==1) {
            
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[parsedData objectForKey:@"app"]objectForKey:@"store_url"] ]];
            if ([[[parsedData objectForKey:@"app"]objectForKey:@"is_core"]intValue]==1) {
                
            }
            else{
                // [self.navigationController popToRootViewControllerAnimated:NO];
            }
        }
        else{
            if ([[[parsedData objectForKey:@"app"]objectForKey:@"is_core"]intValue]==1) {
                
            }
            else{
                [self.navigationController popToRootViewControllerAnimated:NO];
                alertView.hidden=YES;
            }
        }
    }
    else
    {
        if (buttonIndex==1) {
            [self LoadMetaData];
        }
    }
}
-(IBAction)refresh:(id)sender{
    [self LoadMetaData];
    
}
-(void)CheckImageAndLoad:(NSString*)fileName{
    NSString*folderName=@"IPhoneImages";
    [SFileHandler CreateFloder:folderName];
    BOOL check= [SFileHandler checkFile:[NSString stringWithFormat:@"%@.png",fileName] Type:folderName];
    if ( check== NO) {
        [SFileHandler loadImageFromUrl:[NSString stringWithFormat:@"%@%@.png",[Global getInstance].appInfo.app.imgsBaseUrl,fileName] FileName:[NSString stringWithFormat:@"%@.png",fileName] Type:folderName];
    }
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    [NMLocationManager stopLocationTracking];
}
@end

//
//  TabsViewController.m
//  Reyada
//
//  Created by MohamedMansour on 1/6/15.
//  Copyright (c) 2015 Sarmady.net. All rights reserved.
//

#import "TabsViewController.h"
#import "WebController.h"
#import "Global.h"
#import "Tabs.h"
#import "SettingViewController.h"
#import "SFileHandler.h"
#import "App.h"
@interface TabsViewController ()

@end

@implementation TabsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (UIImage *)imageByCroppingImage:(UIImage *)image toSize:(CGSize)size
{
    // not equivalent to image.size (which depends on the imageOrientation)!
    double x = (image.size.width - size.width) / 2.0;
    double y = (image.size.height - size.height) / 2.0;
    
    CGRect cropRect = CGRectMake(x, y, size.width, size.height);
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], cropRect);
    
    UIImage *cropped = [UIImage imageWithCGImage:imageRef scale:image.scale
                                     orientation:image.imageOrientation];
    CGImageRelease(imageRef);
    
    return cropped;
}

- (UIImage *)pbResizedImageWithWidth:(CGFloat)newWidth andTiledAreaFrom:(CGFloat)from1 to:(CGFloat)to1 andFrom:(CGFloat)from2 to:(CGFloat)to2 sourceImage:(UIImage*)sourceImage {
    NSAssert(sourceImage.size.width < newWidth, @"Cannot scale NewWidth %f > self.size.width %f", newWidth, sourceImage.size.width);
    
    CGFloat originalWidth = sourceImage.size.width;
    CGFloat tiledAreaWidth = (newWidth - originalWidth)/2;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(originalWidth + tiledAreaWidth, sourceImage.size.height), NO, sourceImage.scale);
    
    UIImage *firstResizable = [sourceImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, from1, 0, originalWidth - to1) resizingMode:UIImageResizingModeTile];
    [firstResizable drawInRect:CGRectMake(0, 0, originalWidth + tiledAreaWidth, sourceImage.size.height)];
    
    UIImage *leftPart = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(newWidth, sourceImage.size.height), NO, sourceImage.scale);
    
    UIImage *secondResizable = [leftPart resizableImageWithCapInsets:UIEdgeInsetsMake(0, from2 + tiledAreaWidth, 0, originalWidth - to2) resizingMode:UIImageResizingModeTile];
    [secondResizable drawInRect:CGRectMake(0, 0, newWidth, sourceImage.size.height)];
    
    UIImage *fullImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return fullImage;
}
- (UIImage*)imageWithImage:(UIImage *)image
              scaledToSize:(CGSize)newSize
{
    
   
      float  scaleFactor = newSize.height / image.size.height;
    
    
    CGSize newSize2 = newSize;
    newSize2.width = image.size.width * scaleFactor;
  
    
    UIGraphicsBeginImageContext(newSize2);
    [image drawInRect:CGRectMake(0,0,newSize2.width,newSize2.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
-(UIImage*)handelImage:(UIImage *)image tabSize:(CGSize)tabSize {
    UIImage *outputImage;
    
    float  scaleFactor = tabSize.height / image.size.height;
    CGSize newSize2 = tabSize;
    newSize2.width = image.size.width * scaleFactor;
    if (tabSize.width>newSize2.width) {
        //stertch
        UIImage *source =[self imageWithImage:image scaledToSize:tabSize];
       outputImage= [self pbResizedImageWithWidth:tabSize.width+2 andTiledAreaFrom:5 to:10 andFrom:source.size.width-10 to:source.size.width-5 sourceImage:source];
    }
    else if (tabSize.width<newSize2.width) {
        //cropping
        outputImage=[self imageByCroppingImage:[self imageWithImage:image scaledToSize:tabSize] toSize:tabSize];
        //outputImage=[self imageWithImage:image scaledToSize:tabSize];
        
    }
    

    return outputImage;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString*folderName=@"IPhoneImages";
    // Do any additional setup after loading the view.
    NSMutableArray *tabViewControllers = [[NSMutableArray alloc] init];
    int tabBarWidth=self.tabBar.frame.size.width;
   if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
       tabBarWidth=tabBarWidth/3;
    
    
    
    NSMutableArray *tabs=[[NSMutableArray alloc] init];
    for (Tabs *tab in [Global getInstance].appInfo.tabs) {
        if (tab.tabType==1||tab.tabType==2) {
            [tabs addObject:tab];
        }
    }
    int tabWidth= (tabBarWidth/tabs.count);
    int maxWid=(tabBarWidth/5);
    tabWidth=tabWidth<maxWid?maxWid:tabWidth;
    for (int i=0;i<tabs.count;i++) {
        Tabs *tab =[ tabs objectAtIndex:i];
        UIImage *normal;
        UIImage *active;
        
       normal= [SFileHandler loadImage:[NSString stringWithFormat:@"%@.png",tab.tabImage] Type:folderName];
        active=[SFileHandler loadImage:[NSString stringWithFormat:@"%@.png",tab.tabImageActive] Type:folderName];
        if (normal==nil||active==nil) {
            normal=[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",tab.tabImage]];
            active=[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",tab.tabImageActive]];
        }
       
        
        normal=[self handelImage:normal tabSize:CGSizeMake(tabWidth, self.tabBar.frame.size.height)];
       normal = [normal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
       active=[self handelImage:active tabSize:CGSizeMake(tabWidth, self.tabBar.frame.size.height)];
         active = [active imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        if (tab.tabType==1) {
            
        NSString *url=tab.tabMobileUrl;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                url=tab.tabUrl;
        WebController  *webController=[[WebController alloc] initWithType:url];
       // webController.tabBarItem = [[UITabBarItem alloc] init];
            
            [webController.tabBarItem setFinishedSelectedImage:active withFinishedUnselectedImage:normal];
            if (i>=4&&tabs.count!=5)
                webController.tabBarItem.title=tab.tabTitle;
            webController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
            [tabViewControllers addObject:webController];
        }
        else if (tab.tabType==2){
            
            SettingViewController  *settingViewController=[[SettingViewController alloc] init];
            [settingViewController.tabBarItem setFinishedSelectedImage:active withFinishedUnselectedImage:normal];
            if (i>=4&&tabs.count!=5)
                settingViewController.tabBarItem.title=tab.tabTitle;
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            {
                if(tabs.count==2)
                    settingViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 17, -6, 0);
                else
                    settingViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
                
            }
            else
                settingViewController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
            [tabViewControllers addObject:settingViewController];
        
        
        }
    }
   
    [self setViewControllers:tabViewControllers];
//    if([Global getInstance].appInfo.tabs.count){
//        self.tabBar.hidden=YES;
//    }
    
}
-(void)viewDidAppear:(BOOL)animated{
[self setSelectedIndex:[Global getInstance].appInfo.tabs.count];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

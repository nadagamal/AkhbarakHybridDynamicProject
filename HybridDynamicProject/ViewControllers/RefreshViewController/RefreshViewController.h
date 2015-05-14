//
//  AboutViewController.h
//  almasryalyoum
//
//  Created by MohamedMansour on 9/21/14.
//  Copyright (c) 2014 Sarmady.net. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RefreshViewController;
@protocol RefreshDelegate <NSObject>

-(void)offlineViewDidRefreshButtonClicked;

@end


@interface RefreshViewController : UIViewController

@property (nonatomic,retain) id<RefreshDelegate> delegate;

-(IBAction)refreshClicked:(id)sender;
@end

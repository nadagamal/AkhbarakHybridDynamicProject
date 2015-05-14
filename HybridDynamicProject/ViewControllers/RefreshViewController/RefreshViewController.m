//
//  AboutViewController.m
//  almasryalyoum
//
//  Created by MohamedMansour on 9/21/14.
//  Copyright (c) 2014 Sarmady.net. All rights reserved.
//

#import "RefreshViewController.h"

@interface RefreshViewController ()

@end

@implementation RefreshViewController

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
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}
-(IBAction)refreshClicked:(id)sender{
    if ([self.delegate respondsToSelector:@selector(offlineViewDidRefreshButtonClicked)]) {
        [self.delegate offlineViewDidRefreshButtonClicked];
    }

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

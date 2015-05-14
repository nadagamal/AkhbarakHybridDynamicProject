//
//  Global.h
//  New-Muslim
//
//  Created by Shaker Samy on 2/2/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>
#import "AppInfo.h"




@interface Global : NSObject
{

    
    
}



@property(nonatomic,retain) AppInfo *appInfo;


+(Global *)getInstance;


@end

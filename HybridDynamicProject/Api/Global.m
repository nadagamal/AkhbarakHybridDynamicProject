//
//  Global.m
//  New-Muslim
//
//  Created by Shaker Samy on 2/2/13.
//
//

#import "Global.h"


@implementation Global

@synthesize appInfo;



static Global * instance =nil;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+(Global *) getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            
            instance= [Global new];
        }
    }
    return instance;
}

@end

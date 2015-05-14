//
//  Tabs.h
//
//  Created by MacBookPro  on 1/15/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Tabs : NSObject <NSCoding>

@property (nonatomic, assign) double tabType;
@property (nonatomic, retain) NSString *tabTitle;
@property (nonatomic, retain) NSString *tabMobileUrl;
@property (nonatomic, retain) NSString *tabImage;
@property (nonatomic, retain) NSString *tabImageActive;
@property (nonatomic, retain) NSString *tabUrl;

+ (Tabs *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

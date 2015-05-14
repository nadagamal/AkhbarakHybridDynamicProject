//
//  App.h
//
//  Created by MacBookPro  on 1/15/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface App : NSObject <NSCoding>

@property (nonatomic, retain) NSString *storeUrl;
@property (nonatomic, retain) NSString *msg;
@property (nonatomic, retain) NSString *imgsBaseUrl;
@property (nonatomic, assign) double isCore;
@property (nonatomic, retain) NSString *version;
@property (nonatomic, assign) double isActive;
@property (nonatomic, retain) NSString *imgsVersion;

+ (App *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

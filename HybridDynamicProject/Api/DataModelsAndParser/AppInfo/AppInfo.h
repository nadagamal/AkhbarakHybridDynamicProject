//
//  AppInfo.h
//
//  Created by MacBookPro  on 1/15/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class App, Message;

@interface AppInfo : NSObject <NSCoding>

@property (nonatomic, retain) App *app;
@property (nonatomic, retain) Message *message;
@property (nonatomic, retain) NSArray *tabs;
@property (nonatomic, retain) NSArray *urls;

+ (AppInfo *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

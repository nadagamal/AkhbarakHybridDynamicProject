//
//  AppInfo.m
//
//  Created by MacBookPro  on 1/15/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "AppInfo.h"
#import "App.h"
#import "Message.h"
#import "Tabs.h"
#import "Urls.h"


@interface AppInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AppInfo

@synthesize app = _app;
@synthesize message = _message;
@synthesize tabs = _tabs;
@synthesize urls = _urls;


+ (AppInfo *)modelObjectWithDictionary:(NSDictionary *)dict
{
    AppInfo *instance = [[AppInfo alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.app = [App modelObjectWithDictionary:[dict objectForKey:@"app"]];
            self.message = [Message modelObjectWithDictionary:[dict objectForKey:@"message"]];
    NSObject *receivedTabs = [dict objectForKey:@"tabs"];
    NSMutableArray *parsedTabs = [NSMutableArray array];
    if ([receivedTabs isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTabs) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTabs addObject:[Tabs modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedTabs isKindOfClass:[NSDictionary class]]) {
       [parsedTabs addObject:[Tabs modelObjectWithDictionary:(NSDictionary *)receivedTabs]];
    }

    self.tabs = [NSArray arrayWithArray:parsedTabs];
    NSObject *receivedUrls = [dict objectForKey:@"urls"];
    NSMutableArray *parsedUrls = [NSMutableArray array];
    if ([receivedUrls isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedUrls) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedUrls addObject:[Urls modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedUrls isKindOfClass:[NSDictionary class]]) {
       [parsedUrls addObject:[Urls modelObjectWithDictionary:(NSDictionary *)receivedUrls]];
    }

    self.urls = [NSArray arrayWithArray:parsedUrls];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.app dictionaryRepresentation] forKey:@"app"];
    [mutableDict setValue:[self.message dictionaryRepresentation] forKey:@"message"];
NSMutableArray *tempArrayForTabs = [NSMutableArray array];
    for (NSObject *subArrayObject in self.tabs) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTabs addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTabs addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTabs] forKey:@"tabs"];
NSMutableArray *tempArrayForUrls = [NSMutableArray array];
    for (NSObject *subArrayObject in self.urls) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForUrls addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForUrls addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForUrls] forKey:@"urls"];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.app = [aDecoder decodeObjectForKey:@"app"];
    self.message = [aDecoder decodeObjectForKey:@"message"];
    self.tabs = [aDecoder decodeObjectForKey:@"tabs"];
    self.urls = [aDecoder decodeObjectForKey:@"urls"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_app forKey:@"app"];
    [aCoder encodeObject:_message forKey:@"message"];
    [aCoder encodeObject:_tabs forKey:@"tabs"];
    [aCoder encodeObject:_urls forKey:@"urls"];
}


@end

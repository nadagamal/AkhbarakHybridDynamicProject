//
//  Tabs.m
//
//  Created by MacBookPro  on 1/15/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Tabs.h"


@interface Tabs ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Tabs

@synthesize tabType = _tabType;
@synthesize tabTitle = _tabTitle;
@synthesize tabMobileUrl = _tabMobileUrl;
@synthesize tabImage = _tabImage;
@synthesize tabImageActive = _tabImageActive;
@synthesize tabUrl = _tabUrl;


+ (Tabs *)modelObjectWithDictionary:(NSDictionary *)dict
{
    Tabs *instance = [[Tabs alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.tabType = [[dict objectForKey:@"tab_type"]==nil?@"3":[dict objectForKey:@"tab_type"] doubleValue];
            self.tabTitle = [self objectOrNilForKey:@"tab_title" fromDictionary:dict];
            self.tabMobileUrl = [self objectOrNilForKey:@"tab_mobile_url" fromDictionary:dict];
            self.tabImage = [self objectOrNilForKey:@"tab_image" fromDictionary:dict];
            self.tabImageActive = [self objectOrNilForKey:@"tab_image_active" fromDictionary:dict];
            self.tabUrl = [self objectOrNilForKey:@"tab_url" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.tabType] forKey:@"tab_type"];
    [mutableDict setValue:self.tabTitle forKey:@"tab_title"];
    [mutableDict setValue:self.tabMobileUrl forKey:@"tab_mobile_url"];
    [mutableDict setValue:self.tabImage forKey:@"tab_image"];
    [mutableDict setValue:self.tabImageActive forKey:@"tab_image_active"];
    [mutableDict setValue:self.tabUrl forKey:@"tab_url"];

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

    self.tabType = [aDecoder decodeDoubleForKey:@"tabType"];
    self.tabTitle = [aDecoder decodeObjectForKey:@"tabTitle"];
    self.tabMobileUrl = [aDecoder decodeObjectForKey:@"tabMobileUrl"];
    self.tabImage = [aDecoder decodeObjectForKey:@"tabImage"];
    self.tabImageActive = [aDecoder decodeObjectForKey:@"tabImageActive"];
    self.tabUrl = [aDecoder decodeObjectForKey:@"tabUrl"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_tabType forKey:@"tabType"];
    [aCoder encodeObject:_tabTitle forKey:@"tabTitle"];
    [aCoder encodeObject:_tabMobileUrl forKey:@"tabMobileUrl"];
    [aCoder encodeObject:_tabImage forKey:@"tabImage"];
    [aCoder encodeObject:_tabImageActive forKey:@"tabImageActive"];
    [aCoder encodeObject:_tabUrl forKey:@"tabUrl"];
}


@end

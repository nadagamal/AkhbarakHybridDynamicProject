//
//  App.m
//
//  Created by MacBookPro  on 1/15/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "App.h"


@interface App ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation App

@synthesize storeUrl = _storeUrl;
@synthesize msg = _msg;
@synthesize imgsBaseUrl = _imgsBaseUrl;
@synthesize isCore = _isCore;
@synthesize version = _version;
@synthesize isActive = _isActive;
@synthesize imgsVersion = _imgsVersion;


+ (App *)modelObjectWithDictionary:(NSDictionary *)dict
{
    App *instance = [[App alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.storeUrl = [self objectOrNilForKey:@"store_url" fromDictionary:dict];
            self.msg = [self objectOrNilForKey:@"msg" fromDictionary:dict];
            self.imgsBaseUrl = [self objectOrNilForKey:@"imgs_base_url" fromDictionary:dict];
            self.isCore = [[dict objectForKey:@"is_core"] doubleValue];
            self.version = [self objectOrNilForKey:@"version" fromDictionary:dict];
            self.isActive = [[dict objectForKey:@"is_active"] doubleValue];
            self.imgsVersion = [self objectOrNilForKey:@"imgs_version" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.storeUrl forKey:@"store_url"];
    [mutableDict setValue:self.msg forKey:@"msg"];
    [mutableDict setValue:self.imgsBaseUrl forKey:@"imgs_base_url"];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isCore] forKey:@"is_core"];
    [mutableDict setValue:self.version forKey:@"version"];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isActive] forKey:@"is_active"];
    [mutableDict setValue:self.imgsVersion forKey:@"imgs_version"];

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

    self.storeUrl = [aDecoder decodeObjectForKey:@"storeUrl"];
    self.msg = [aDecoder decodeObjectForKey:@"msg"];
    self.imgsBaseUrl = [aDecoder decodeObjectForKey:@"imgsBaseUrl"];
    self.isCore = [aDecoder decodeDoubleForKey:@"isCore"];
    self.version = [aDecoder decodeObjectForKey:@"version"];
    self.isActive = [aDecoder decodeDoubleForKey:@"isActive"];
    self.imgsVersion = [aDecoder decodeObjectForKey:@"imgsVersion"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_storeUrl forKey:@"storeUrl"];
    [aCoder encodeObject:_msg forKey:@"msg"];
    [aCoder encodeObject:_imgsBaseUrl forKey:@"imgsBaseUrl"];
    [aCoder encodeDouble:_isCore forKey:@"isCore"];
    [aCoder encodeObject:_version forKey:@"version"];
    [aCoder encodeDouble:_isActive forKey:@"isActive"];
    [aCoder encodeObject:_imgsVersion forKey:@"imgsVersion"];
}


@end

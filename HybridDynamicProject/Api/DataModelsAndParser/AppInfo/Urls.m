//
//  Urls.m
//
//  Created by MacBookPro  on 1/15/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Urls.h"


@interface Urls ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Urls

@synthesize durl = _durl;
@synthesize murl = _murl;


+ (Urls *)modelObjectWithDictionary:(NSDictionary *)dict
{
    Urls *instance = [[Urls alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.durl = [self objectOrNilForKey:@"durl" fromDictionary:dict];
            self.murl = [self objectOrNilForKey:@"murl" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.durl forKey:@"durl"];
    [mutableDict setValue:self.murl forKey:@"murl"];

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

    self.durl = [aDecoder decodeObjectForKey:@"durl"];
    self.murl = [aDecoder decodeObjectForKey:@"murl"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_durl forKey:@"durl"];
    [aCoder encodeObject:_murl forKey:@"murl"];
}


@end

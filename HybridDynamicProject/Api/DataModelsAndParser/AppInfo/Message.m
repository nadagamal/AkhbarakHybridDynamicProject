//
//  Message.m
//
//  Created by MacBookPro  on 1/15/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "Message.h"


@interface Message ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Message

@synthesize isRepeated = _isRepeated;
@synthesize msgId = _msgId;
@synthesize isActive = _isActive;
@synthesize msg = _msg;
@synthesize msgUrl = _msgUrl;


+ (Message *)modelObjectWithDictionary:(NSDictionary *)dict
{
    Message *instance = [[Message alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.isRepeated = [[dict objectForKey:@"is_repeated"] doubleValue];
            self.msgId = [[dict objectForKey:@"msg_id"] doubleValue];
            self.isActive = [[dict objectForKey:@"is_active"] doubleValue];
            self.msg = [self objectOrNilForKey:@"msg" fromDictionary:dict];
            self.msgUrl = [self objectOrNilForKey:@"msg_url" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isRepeated] forKey:@"is_repeated"];
    [mutableDict setValue:[NSNumber numberWithDouble:self.msgId] forKey:@"msg_id"];
    [mutableDict setValue:[NSNumber numberWithDouble:self.isActive] forKey:@"is_active"];
    [mutableDict setValue:self.msg forKey:@"msg"];
    [mutableDict setValue:self.msgUrl forKey:@"msg_url"];

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

    self.isRepeated = [aDecoder decodeDoubleForKey:@"isRepeated"];
    self.msgId = [aDecoder decodeDoubleForKey:@"msgId"];
    self.isActive = [aDecoder decodeDoubleForKey:@"isActive"];
    self.msg = [aDecoder decodeObjectForKey:@"msg"];
    self.msgUrl = [aDecoder decodeObjectForKey:@"msgUrl"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_isRepeated forKey:@"isRepeated"];
    [aCoder encodeDouble:_msgId forKey:@"msgId"];
    [aCoder encodeDouble:_isActive forKey:@"isActive"];
    [aCoder encodeObject:_msg forKey:@"msg"];
    [aCoder encodeObject:_msgUrl forKey:@"msgUrl"];
}


@end

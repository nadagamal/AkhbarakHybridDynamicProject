//
//  Message.h
//
//  Created by MacBookPro  on 1/15/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Message : NSObject <NSCoding>

@property (nonatomic, assign) double isRepeated;
@property (nonatomic, assign) double msgId;
@property (nonatomic, assign) double isActive;
@property (nonatomic, retain) NSString *msg;
@property (nonatomic, retain) NSString *msgUrl;

+ (Message *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

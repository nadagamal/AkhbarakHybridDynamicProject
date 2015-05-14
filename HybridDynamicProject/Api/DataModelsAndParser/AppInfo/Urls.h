//
//  Urls.h
//
//  Created by MacBookPro  on 1/15/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Urls : NSObject <NSCoding>

@property (nonatomic, retain) NSString *durl;
@property (nonatomic, retain) NSString *murl;

+ (Urls *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

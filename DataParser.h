//
//  DataParser.h
//  Safley
//
//  Created by Nada Gamal on 9/30/14.
//  Copyright (c) 2014 Nada Gamal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataParser : NSObject
+ (NSDictionary *)parseData:(NSMutableData*)data;
+ (NSArray *)parseDataArray:(NSMutableData*)data;
@end

//
//  DataParser.m
//  Safley
//
//  Created by Nada Gamal on 9/30/14.
//  Copyright (c) 2014 Nada Gamal. All rights reserved.
//

#import "DataParser.h"

@implementation DataParser
+ (NSDictionary *)parseData:(NSMutableData*)data{
    if (data == nil) {
        return nil;
    }
    NSError* error = nil;
    NSLog(@"Data:  %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    
    NSDictionary *jsonData =[NSJSONSerialization JSONObjectWithData:data
                                                            options: NSJSONReadingMutableContainers
                                                              error: &error];
    if (error) {
        NSLog(@"JSON Parsing Error:  %@", error);
        return nil;
    }
    return jsonData;
}
+ (NSArray *)parseDataArray:(NSMutableData*)data{
    if (data == nil) {
        return nil;
    }
    NSError* error = nil;
    NSLog(@"Data:  %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    
    NSArray *jsonData =[NSJSONSerialization JSONObjectWithData:data
                                                            options: NSJSONReadingMutableContainers
                                                              error: &error];
    if (error) {
        NSLog(@"JSON Parsing Error:  %@", error);
        return nil;
    }
    return jsonData;
}
@end

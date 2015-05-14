/*
 * Copyright 2012 Inomera Research
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import <Foundation/Foundation.h>

void LoadJSONCategories(void);

@interface NSData (NMJSONDeserializer)

- (id)nm_objectFromJsonData;
- (id)nm_mutableObjectFromJsonData;

@end

@interface NSString (NMJSONDeserializer)

- (id)nm_objectFromJsonSring;
- (id)nm_mutableObjectFromJsonString;

@end

@interface NSArray (NMJSONSerializer)

- (NSData *)nm_jsonData;
- (NSData *)nm_jsonDataWithError:(NSError**)error;
- (NSString *)nm_jsonString;
- (NSString *)nm_jsonStringWithError:(NSError**)error;

@end

@interface NSDictionary (NMJSONSerializer)

- (NSData *)nm_jsonData;
- (NSData *)nm_jsonDataWithError:(NSError**)error;
- (NSString *)nm_jsonString;
- (NSString *)nm_jsonStringWithError:(NSError**)error;

@end
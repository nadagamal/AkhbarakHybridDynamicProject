//
//  FileHandler.h
//  iPhoneXMPP
//
//  Created by Mohamed Mansour on 10/1/12.
//  Copyright (c) 2012 Vodafone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SFileHandler : NSObject
+ (BOOL)saveFileURL:(NSString*)url name:(NSString*)fileName;
+ (BOOL)saveFile:(NSData*)fileData name:(NSString*)fileName Type:(NSString*)type;
+ (void)removeFile:(NSString*)fileName Type:(NSString*)type; 
+ (NSString*)loadFile:(NSString *)fileName Type:(NSString*)type;
+ (BOOL)checkFile:(NSString *)fileName Type:(NSString*)type;
+(void)CreateFloder:(NSString*)FolderName;
+(void)deleteFloder:(NSString*)FolderName;
+(BOOL)createEmptyFile:(NSString*)fileName Type:(NSString*)type;
+ (NSString*)getFilePath:(NSString *)fileName Type:(NSString*)type;
+ (UIImage*)loadImage:(NSString *)fileName Type:(NSString*)type;
+ (void)loadImageFromUrl:(NSString *)url FileName:(NSString *)fileName Type:(NSString*)type;

@end

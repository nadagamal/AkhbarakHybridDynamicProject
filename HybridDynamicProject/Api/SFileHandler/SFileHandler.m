//
//  ImageHandler.m
//  iPhoneXMPP
//
//  Created by new user on 10/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFileHandler.h"

@implementation SFileHandler
+ (BOOL)saveFileURL:(NSString*)url name:(NSString*)fileName {
    
    NSData *fileData=[NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    
    if (fileData==nil) {
        return NO;
    }
    //   NSData *imageData = UIImagePNGRepresentation(image); //convert image into .png format.
    
    NSFileManager *fileManager = [NSFileManager defaultManager];//create instance of NSFileManager
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //create an array and store result of our search for the documents directory in it
    
    NSString *documentsDirectory = [paths objectAtIndex:0]; //create NSString object, that holds our exact path to the documents directory
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:fileName]; //add our image to the path
    
    return  [fileManager createFileAtPath:fullPath contents:fileData attributes:nil]; //finally save the path (image)
    
    NSLog(@"File saved");
    
    
}
+(void)CreateFloder:(NSString*)FolderName{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:FolderName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]){
        
        NSError* error;
        if(  [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error])
            ;// success
        else
        {
            NSLog(@"[%@] ERROR: attempting to write create MyFolder directory", [self class]);
            NSAssert( FALSE, @"Failed to create directory maybe out of disk space?");
        }
    }
    
}
+(void)deleteFloder:(NSString*)FolderName{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:FolderName];
    NSError *error = nil;
    for (NSString *file in [[NSFileManager defaultManager] contentsOfDirectoryAtPath:dataPath error:&error]) {
        [[NSFileManager defaultManager] removeItemAtPath:[dataPath stringByAppendingPathComponent:file] error:&error];
    }

}
+(BOOL)createEmptyFile:(NSString*)fileName Type:(NSString*)type{
    if ([self checkFile:fileName Type:type]) {
        return NO;
    }
    
    //   NSData *imageData = UIImagePNGRepresentation(image); //convert image into .png format.
    
    NSFileManager *fileManager = [NSFileManager defaultManager];//create instance of NSFileManager
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //create an array and store result of our search for the documents directory in it
    
    NSString *documentsDirectory = [paths objectAtIndex:0]; //create NSString object, that holds our exact path to the documents directory
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",type,fileName]]; //add our image to the path
    BOOL done= [fileManager createFileAtPath:fullPath contents:nil attributes:nil];
        
    return done;

}
+ (BOOL)saveFile:(NSData*)fileData name:(NSString*)fileName Type:(NSString*)type {
    
    if ([self checkFile:fileName Type:type]) {
        return NO;
    }
    if (fileData==nil) {
        return NO;
    }
    //   NSData *imageData = UIImagePNGRepresentation(image); //convert image into .png format.
    
    NSFileManager *fileManager = [NSFileManager defaultManager];//create instance of NSFileManager
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //create an array and store result of our search for the documents directory in it
    
    NSString *documentsDirectory = [paths objectAtIndex:0]; //create NSString object, that holds our exact path to the documents directory
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",type,fileName]]; //add our image to the path
    BOOL done= [fileManager createFileAtPath:fullPath contents:fileData attributes:nil];
    if (done) {
        NSLog(@"%@ File saved %@  with size : %i",type,fileName,fileData.length);
    }
    else{
        NSLog(@"%@ File faild %@  with size : %i",type,fileName,fileData.length);
    }
    
    return done;  //finally save the path (image)
    
    
}
//removing an image

+ (void)removeFile:(NSString *)fileName Type:(NSString*)type{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",type,fileName]];
    [fileManager removeItemAtPath: fullPath error:NULL];
    
    NSLog(@"file removed");
    
}

//loading an image

+ (NSString*)loadFile:(NSString *)fileName Type:(NSString*)type{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",type,fileName]];
    //  return  [NSData dataWithContentsOfFile:fullPath];
    return fullPath;
}
+ (UIImage*)loadImage:(NSString *)fileName Type:(NSString*)type{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",type,fileName]];
      return  [UIImage imageWithData:[NSData dataWithContentsOfFile:fullPath]];
    
}
+ (void)loadImageFromUrl:(NSString *)url FileName:(NSString *)fileName Type:(NSString*)type{
    
    NSData *ImageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    [self saveFile:ImageData name:fileName Type:type];
    
}
+ (NSString*)getFilePath:(NSString *)fileName Type:(NSString*)type{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",type,fileName]];
    
    //BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:fullPath];
    
    return fullPath;
}

+ (BOOL)checkFile:(NSString *)fileName Type:(NSString*)type{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",type,fileName]];
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:fullPath];
    
    return fileExists;
}

@end

//
//  LocalFileManager.h
//  CookBookByHeart
//
//  Created by mac on 14-9-17.
//  Copyright (c) 2014年 LPJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyArticleModel.h"

#define FILE_M [NSFileManager defaultManager]

@interface LocalFileManager : NSObject

+(NSArray *)readFromFile;
+(void)writeToFile:(NSArray *)ObjArray;
+(void)createPathIfNotExist;
+(void)writeToFileWithObject:(MyArticleModel *)article;
+(void)removeObjFromFile:(MyArticleModel *)article;
+(void)removeArticleFile;
+(void)replaceToFileWithObject:(MyArticleModel *)article;
@end

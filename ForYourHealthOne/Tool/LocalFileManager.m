
//
//  LocalFileManager.m
//  CookBookByHeart
//
//  Created by mac on 14-9-17.
//  Copyright (c) 2014年 LPJ. All rights reserved.
//

#import "LocalFileManager.h"
#import "MyCommonTool.h"

@implementation LocalFileManager

//从沙盒中读取文件内容到数组中
+(NSArray *)readFromFile
{
    [self createPathIfNotExist];
    NSArray *objArray = [NSKeyedUnarchiver unarchiveObjectWithFile:[MyCommonTool ArticlePath]];
    return objArray;
}


+(void)writeToFileWithObject:(MyArticleModel *)article
{
    [self createPathIfNotExist];
    NSMutableArray *oldArray = [[NSMutableArray alloc]initWithArray:[self readFromFile]];
    
    for (MyArticleModel *obj1 in oldArray)
    {
        if ([article.articleID  isEqualToString:obj1.articleID])
        {
            [oldArray removeObject:obj1];
            break;
        }
    }
    [oldArray insertObject:article atIndex:0];
    [NSKeyedArchiver archiveRootObject:oldArray toFile:[MyCommonTool ArticlePath]];
}

+(void)replaceToFileWithObject:(MyArticleModel *)article
{
    [self createPathIfNotExist];
    NSMutableArray *oldArray = [[NSMutableArray alloc]initWithArray:[self readFromFile]];
    int i = 0;
    for (MyArticleModel *obj1 in oldArray)
    {
        if ([article.articleID  isEqualToString: obj1.articleID])
        {
            [oldArray removeObject:obj1];
            break;
        }
        i ++;
    }
    [oldArray insertObject:article atIndex:i];
    [NSKeyedArchiver archiveRootObject:oldArray toFile:[MyCommonTool ArticlePath]];
}

//将对象数组序列化写入沙盒
+(void)writeToFile:(NSArray *)ObjArray
{
    [self createPathIfNotExist];
    NSMutableArray *oldArray = [[NSMutableArray alloc]initWithArray:[self readFromFile]];
    NSMutableArray *tmpArray = [[NSMutableArray alloc]initWithArray:ObjArray];
    
    for (MyArticleModel *obj1 in oldArray)
    {
        for (MyArticleModel *obj in tmpArray)
        {
            //DLOG(@"--%@--%@",obj.shipuID,obj1.shipuID);
            if ([obj.articleID isEqualToString:obj1.articleID])
            {
                [tmpArray removeObject:obj];
                break;
            }
        }
    }
    [oldArray addObjectsFromArray:tmpArray];
    
    [NSKeyedArchiver archiveRootObject:oldArray toFile:[MyCommonTool ArticlePath]];
}


+(void)removeObjFromFile:(MyArticleModel *)article
{
    [self createPathIfNotExist];
    NSMutableArray *oldArray = [[NSMutableArray alloc]initWithArray:[self readFromFile]];
    for (MyArticleModel *obj1 in oldArray)
    {
        if ([article.articleID  isEqualToString:obj1.articleID])
        {
            [oldArray removeObject:obj1];
            break;
        }
    }
    [NSKeyedArchiver archiveRootObject:oldArray toFile:[MyCommonTool ArticlePath]];
}


//闹钟路径不存在则创建闹钟存放路径
+(void)createPathIfNotExist
{
    if(![FILE_M fileExistsAtPath:[MyCommonTool ArticlePathDirectory]])
    {
        [FILE_M createDirectoryAtPath:[MyCommonTool ArticlePathDirectory] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if (![FILE_M fileExistsAtPath:[MyCommonTool ArticlePath]])
    {
        [FILE_M createFileAtPath:[MyCommonTool ArticlePath] contents:nil attributes:nil];
    }
}

+(void)removeArticleFile
{
    if ([FILE_M fileExistsAtPath:[MyCommonTool ArticlePath]])
    {
        NSError *err;
        [FILE_M removeItemAtPath:[MyCommonTool ArticlePath] error:&err];
    }
}

@end

//
//  CommonTool.m
//  CookBookByHeart
//
//  Created by mac on 14-9-17.
//  Copyright (c) 2014年 LPJ. All rights reserved.
//

#import "MyCommonTool.h"

@implementation MyCommonTool


+(NSString *)getUUid
{
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    NSString *strUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
    CFRelease(uuidRef);
    return strUUID;
}

+(NSString *)getCurrentDate
{
    NSDateFormatter *formatter1=[[NSDateFormatter alloc]init];
    formatter1.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    NSString *dateStr = [formatter1 stringFromDate:[NSDate date]];
    return dateStr;
}

+ (CGFloat)getHeightOfText:(NSString *)text forWidth:(CGFloat)width andFontsize:(CGFloat)fontsize
{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, 0) options: NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontsize]} context:nil];
    return rect.size.height;
}

+ (NSString *)ArticlePath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Article/Article.plist"];
}


+ (NSString *)ArticlePathDirectory
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Article"];
}

@end

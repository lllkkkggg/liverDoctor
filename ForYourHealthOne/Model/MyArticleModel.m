//
//  MyArticleModel.m
//  ForYourHealthOne
//
//  Created by iosOne on 16/9/7.
//  Copyright © 2016年 吕盼举. All rights reserved.
//

#import "MyArticleModel.h"

@implementation MyArticleModel

//编码
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.timeStr forKey:@"timeStr"];
    [aCoder encodeObject:self.articleID forKey:@"articleID"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.content forKey:@"content"];
    [aCoder encodeObject:[NSNumber numberWithBool:self.isCollected] forKey:@"isCollected"];
    [aCoder encodeObject:[NSNumber numberWithFloat:self.height] forKey:@"height"];
    [aCoder encodeObject:[NSNumber numberWithBool:self.isAll] forKey:@"isAll"];
}

//解码
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        self.timeStr = [aDecoder decodeObjectForKey:@"timeStr"];
        self.articleID = [aDecoder decodeObjectForKey:@"articleID"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.isCollected = [[aDecoder decodeObjectForKey:@"isCollected"] boolValue];
        self.height = [[aDecoder decodeObjectForKey:@"height"] floatValue];
        self.isAll = [[aDecoder decodeObjectForKey:@"isAll"] boolValue];
    }
    return self;
}

@end

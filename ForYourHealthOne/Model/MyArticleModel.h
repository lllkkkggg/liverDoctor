//
//  MyArticleModel.h
//  ForYourHealthOne
//
//  Created by iosOne on 16/9/7.
//  Copyright © 2016年 吕盼举. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyArticleModel : NSObject

@property(nonatomic,copy)NSString *articleID;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *timeStr;
@property(nonatomic,assign)BOOL isCollected;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,assign)BOOL isAll;
@end

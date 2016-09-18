//
//  MyArticleTableViewCell.h
//  ForYourHealthOne
//
//  Created by iosOne on 16/9/7.
//  Copyright © 2016年 吕盼举. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyArticleTableViewCellDelegate <NSObject>

@optional
-(void)deleteArticleWithRow:(NSInteger)row;
-(void)deCollectArticleWithRow:(NSInteger)row;
-(void)allBtnClickWithRow:(NSInteger)row;
@end

@interface MyArticleTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *allBtnHeight;
@property (weak, nonatomic) IBOutlet UIButton *allBtn;
@property(nonatomic,assign)id<MyArticleTableViewCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *buttonLeft;
@property (weak, nonatomic) IBOutlet UIButton *buttonRight;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property(nonatomic,strong) MyArticleModel *model;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,assign)NSInteger row;
@property(nonatomic,assign)BOOL isAll;
@property(nonatomic,copy)NSString *searchStr;
-(void)configWithArticle:(MyArticleModel *)model;
-(void)configWithArticle:(MyArticleModel *)model withType:(NSInteger)type;
@end

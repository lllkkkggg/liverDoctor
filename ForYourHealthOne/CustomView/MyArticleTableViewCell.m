//
//  MyArticleTableViewCell.m
//  ForYourHealthOne
//
//  Created by iosOne on 16/9/7.
//  Copyright © 2016年 吕盼举. All rights reserved.
//

#import "MyArticleTableViewCell.h"

@implementation MyArticleTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.buttonLeft.layer.cornerRadius = 15;
    self.buttonLeft.layer.masksToBounds = YES;
    self.buttonRight.layer.cornerRadius = 15;
    self.buttonRight.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configWithArticle:(MyArticleModel *)model
{
    self.model = model;
    self.titleLab.text = model.title;
    self.contentLab.text = model.content;
    self.timeLab.text = model.timeStr;
    float height = [MyCommonTool getHeightOfText:model.content forWidth:self.frame.size.width-25 andFontsize:15];
    if (height > 50)
    {
        if (self.model.isAll)
        {
         //   self.model.height = height + 115;
            [self.allBtn setTitle:@"收起" forState:UIControlStateNormal];
        }
        else
        {
        //    self.model.height = 50 + 115;
            [self.allBtn setTitle:@"全部" forState:UIControlStateNormal];
        }
        self.allBtnHeight.constant = 25;
        self.allBtn.hidden = NO;
    }
    else
    {
     //    self.model.height = 60 + 90;
        self.allBtnHeight.constant = 0;
        self.allBtn.hidden = YES;
    }

    if (model.isCollected)
    {
        [self.buttonLeft setTitle:@"取消收藏" forState:UIControlStateNormal];
    }
    else
    {
         [self.buttonLeft setTitle:@"收藏" forState:UIControlStateNormal];
    }
}

-(void)configWithArticle:(MyArticleModel *)model withType:(NSInteger)type
{
    self.model = model;
    self.titleLab.text = model.title;
    self.contentLab.text = model.content;
    self.timeLab.text = model.timeStr;
    self.buttonLeft.hidden = YES;
    float height = [MyCommonTool getHeightOfText:model.content forWidth:self.frame.size.width-25 andFontsize:15];
    if (height > 50)
    {
        if (self.model.isAll)
        {
          //  self.model.height = height + 115;
            [self.allBtn setTitle:@"收起" forState:UIControlStateNormal];
        }
        else
        {
         //   self.model.height = 50 + 115;
            [self.allBtn setTitle:@"全部" forState:UIControlStateNormal];
        }
        self.allBtnHeight.constant = 25;
        self.allBtn.hidden = NO;
    }
    else
    {
     //   self.model.height = 60 + 90;
        self.allBtnHeight.constant = 0;
        self.allBtn.hidden = YES;
    }
    

    if (type == 1)
    {
        if (model.isCollected)
        {
            [self.buttonRight setTitle:@"取消收藏" forState:UIControlStateNormal];
        }
        else
        {
            [self.buttonRight setTitle:@"收藏" forState:UIControlStateNormal];
        }
    }
    else
    {
         [self.buttonRight setTitle:@"删除" forState:UIControlStateNormal];
    }

    _index = type;
}

- (IBAction)collectBtnClick:(UIButton *)sender
{
    self.model.isCollected = ! self.model.isCollected;
    [LocalFileManager replaceToFileWithObject:self.model];
    if (_model.isCollected)
    {
        [self.buttonLeft setTitle:@"取消收藏" forState:UIControlStateNormal];
    }
    else
    {
        [self.buttonLeft setTitle:@"收藏" forState:UIControlStateNormal];
    }
}

- (IBAction)shareBtnClick:(UIButton *)sender
{
    if(self.index == 1)
    {
        self.model.isCollected = ! self.model.isCollected;
        [LocalFileManager replaceToFileWithObject:self.model];
        if (_model.isCollected)
        {
            [self.buttonRight setTitle:@"取消收藏" forState:UIControlStateNormal];
        }
        else
        {
            [self.buttonRight setTitle:@"收藏" forState:UIControlStateNormal];
        }
        if ([self.delegate respondsToSelector:@selector(deCollectArticleWithRow:)])
        {
            [self.delegate deCollectArticleWithRow:_row];
        }
    }
    else if(self.index == 2)
    {
        [LocalFileManager removeObjFromFile:self.model];
        if ([self.delegate respondsToSelector:@selector(deleteArticleWithRow:)])
        {
            [self.delegate deleteArticleWithRow:_row];
        }
    }
    else
    {
        NSString *str = [NSString stringWithFormat:@"%@\n%@",self.model.title,self.model.content];
        UIActivityViewController *activityViewController =
        [[UIActivityViewController alloc] initWithActivityItems:@[str] applicationActivities:nil];
        [self.viewController presentViewController:activityViewController animated:YES completion:nil];
    }
}

- (IBAction)allBtnClick:(UIButton *)sender
{
    self.model.isAll = ! self.model.isAll;
    if (self.model.isAll)
    {
        [sender setTitle:@"收起" forState:UIControlStateNormal];
    }
    else
    {
        [sender setTitle:@"全部" forState:UIControlStateNormal];
    }
    if ([self.delegate respondsToSelector:@selector(allBtnClickWithRow:)])
    {
        [self.delegate allBtnClickWithRow:_row];
    }
}

- (UIViewController *)viewController
{
    for (UIView *view = self; view; view = view.superview)
    {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end

//
//  ZDPUpLoadViewController.m
//  ForYourHealthOne
//
//  Created by iosOne on 16/9/7.
//  Copyright © 2016年 吕盼举. All rights reserved.
//

#import "ZDPUpLoadViewController.h"
#import "LocalFileManager.h"
#import "MyArticleModel.h"
#import "MyCommonTool.h"

@interface ZDPUpLoadViewController ()<UITextViewDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *uploadBtn;
@property (weak, nonatomic) IBOutlet UITextField *titleTF;
@property (weak, nonatomic) IBOutlet UITextView *contentTV;
@property (strong, nonatomic) UIBarButtonItem *rightBtn;
@end

@implementation ZDPUpLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _contentTV.layer.masksToBounds = YES;
    _contentTV.layer.cornerRadius = 8;
    _uploadBtn.layer.masksToBounds = YES;
    _uploadBtn.layer.cornerRadius = 15;
    _contentTV.text = @"请输入内容";
    _rightBtn = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(rightClick)];
    _rightBtn.tintColor = [UIColor whiteColor];
    self.contentTV.textContainerInset = UIEdgeInsetsMake(10, 0, 10, 0);
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardhidden:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)rightClick
{
    [self.contentTV resignFirstResponder];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (IBAction)EndEdit:(UITextField *)sender
{
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)keyBoardShow:(NSNotification *)f
{
    NSValue *value = [[f userInfo] objectForKey:@"UIKeyboardBoundsUserInfoKey"];
    NSNumber *durationValue = [f userInfo][UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    CGSize keyboardSize = [value CGRectValue].size;
    
    for (NSLayoutConstraint *constraint in self.view.constraints)
    {
        //获得contentTV底部约束
        if ( constraint.secondItem == self.contentTV &&constraint.firstAttribute == NSLayoutAttributeTop)
        {
            //底部约束修改
            constraint.constant = keyboardSize.height - 80;
            break;
        }
    }
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
        if (self.contentTV.contentSize.height > self.contentTV.frame.size.height)
        {
            self.contentTV.contentOffset = CGPointMake(0,self.contentTV.contentSize.height - self.contentTV.frame.size.height);
        }
    } completion:nil];
    
}

-(void)keyBoardChangeFrame:(NSNotification *)f
{
    NSValue *value = [[f userInfo] objectForKey:@"UIKeyboardBoundsUserInfoKey"];
    NSNumber *durationValue = [f userInfo][UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    CGSize keyboardSize = [value CGRectValue].size;
    for (NSLayoutConstraint *constraint in self.view.constraints) {
        //获得contentTV底部约束
        if (constraint.secondItem == self.contentTV &&constraint.firstAttribute == NSLayoutAttributeTop) {
            //底部约束修改
            constraint.constant = keyboardSize.height - 80;
            break;
        }
    }
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

-(void)keyBoardhidden:(NSNotification *)f
{
    NSNumber *durationValue = [f userInfo][UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    for (NSLayoutConstraint *constraint in self.view.constraints) {
        //获得contentTV底部约束
        if (constraint.secondItem == self.contentTV &&constraint.firstAttribute == NSLayoutAttributeTop) {
            //底部约束修改
            constraint.constant = 10;
            break;
        }
    }
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

- (IBAction)uploadBtnClick:(UIButton *)sender
{
    NSString *str0 =  [_titleTF.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *str1 = [_contentTV.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if(_titleTF.text == nil || str0.length == 0)
    {
        [MBProgressHUD ShowMBPressageMessage:@"请输入有效标题" withView:nil];
        return;
    }
    if (_contentTV.text == nil || [str1 isEqualToString:@"请输入内容"])
    {
        [MBProgressHUD ShowMBPressageMessage:@"请输入有效内容" withView:nil];
        return;
    }
    MyArticleModel *model = [[MyArticleModel alloc] init];
    model.articleID = [MyCommonTool getUUid];
    model.title = str0;
    model.content = str1;
    model.timeStr = [MyCommonTool getCurrentDate];
    model.height = [MyCommonTool getHeightOfText:str1 forWidth:self.view.frame.size.width - 25 andFontsize:15];
    [LocalFileManager writeToFileWithObject:model];
    UIAlertView *v = [[UIAlertView alloc] initWithTitle:@"提示" message:@"上传成功" delegate:self cancelButtonTitle:@"继续" otherButtonTitles:@"去查看", nil];
    [v show];
    return;
}


#pragma mark - textViewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem = _rightBtn;
    if ([textView.text isEqualToString:@"请输入内容"]) {
        textView.textColor = [UIColor blackColor];
        textView.text = @"";
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    NSString *str = [_contentTV.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([str isEqualToString:@""])
    {
        textView.text = @"请输入内容";
        textView.textColor = [UIColor grayColor];
    }
    self.navigationItem.rightBarButtonItem = nil;
}

#pragma mark - AlertViewdelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        _titleTF.text = @"";
        _contentTV.text = @"";
    }
    else
    {
        self.tabBarController.selectedIndex = 0;
    }
}


@end

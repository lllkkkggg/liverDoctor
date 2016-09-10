//
//  ZDPDetailViewController.m
//  ForYourHealthOne
//
//  Created by iosOne on 16/9/8.
//  Copyright © 2016年 吕盼举. All rights reserved.
//

#import "ZDPDetailViewController.h"

@interface ZDPDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextView *contentStrTV;

@end

@implementation ZDPDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.titleStr;
    self.contentStrTV.text = self.contentStr;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configRightBtn
{
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(10, 0, 20, 15);
    [rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)rightBtnAction:(UIButton *)btn
{
    
}


@end

//
//  BaseViewController.m
//  ForYourHealthOne
//
//  Created by iosOne on 16/9/7.
//  Copyright © 2016年 吕盼举. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = RGBA(241, 239, 245, 1);
    if (self.navigationController.viewControllers.count > 1)
    {
        [self configBackBtn];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.navigationController.viewControllers.count == 1)
    {
        self.tabBarController.tabBar.hidden = NO;
    }
}

-(void)configBackBtn
{
    UIButton * leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 0, 20, 15)];
    [leftBtn setImage:[UIImage imageNamed:@"common_btn_back"] forState:(UIControlStateNormal)];
    [leftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem=leftItem;
    
}


//左边返回按钮
-(void)leftBtnAction:(UIButton *)sender
{
//    self.navigationController.navigationBar.barTintColor = UIColorFromRGB(0x028de5);
//    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

@end

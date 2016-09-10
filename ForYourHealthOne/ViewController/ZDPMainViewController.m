//
//  ZDPMainViewController.m
//  ForYourHealthOne
//
//  Created by iosOne on 16/9/7.
//  Copyright © 2016年 吕盼举. All rights reserved.
//

#import "ZDPMainViewController.h"
#import "MyArticleTableViewCell.h"
#import "ZDPDetailViewController.h"

@interface ZDPMainViewController ()<UITableViewDelegate,UITableViewDataSource,MyArticleTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *collectArray;
@property(nonatomic,assign)NSInteger index;
@end

@implementation ZDPMainViewController


-(NSMutableArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(NSMutableArray *)collectArray
{
    if (!_collectArray)
    {
        _collectArray = [NSMutableArray array];
    }
    return _collectArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _index = 2;
    [_tableView registerNib:[UINib nibWithNibName:@"MyArticleTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([LocalFileManager readFromFile])
    {
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:[LocalFileManager readFromFile]];
    }

    [self.collectArray removeAllObjects];
    for (MyArticleModel *model in self.dataArray)
    {
        if (model.isCollected)
        {
            [self.collectArray addObject:model];
        }
    }
    [_tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeValueOfSC:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0)
    {
        _index = 2;
    }
    else
    {
        _index = 1;
    }
    [_tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_index == 1)
    {
        return _collectArray.count;
    }
    return self.dataArray.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    MyArticleModel *model = nil;
    if (_index == 1)
    {
        model = (MyArticleModel *)self.collectArray[indexPath.row];
    }
    else
    {
        model = (MyArticleModel *)self.dataArray[indexPath.row];
    }
    cell.row = indexPath.row;
    cell.delegate = self;
    [cell configWithArticle:model withType:_index];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyArticleModel *model = nil;
    if (_index == 1)
    {
        model = (MyArticleModel *)self.collectArray[indexPath.row];
    }
    else
    {
        model = (MyArticleModel *)self.dataArray[indexPath.row];
    }
    float height = [MyCommonTool getHeightOfText:model.content forWidth:self.view.frame.size.width-25 andFontsize:15];
    if (height > 50)
    {
        if (model.isAll)
        {
            height = height + 115;
        }
        else
        {
            height = 50 + 115;
        }
    }
    else
    {
        height = 60 + 90;
    }
    return height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyArticleModel *model = nil;
    if (_index == 1)
    {
        model = (MyArticleModel *)self.collectArray[indexPath.row];
    }
    else
    {
        model = (MyArticleModel *)self.dataArray[indexPath.row];
    }
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ZDPDetailViewController *vc = [main instantiateViewControllerWithIdentifier:@"ZDPDetailViewController"];
    vc.titleStr = model.title;
    vc.contentStr = model.content;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - MyArticleTableViewCellDelegate
-(void)deleteArticleWithRow:(NSInteger)row
{
    [self.dataArray removeObjectAtIndex:row];
    [self.collectArray removeAllObjects];
    for (MyArticleModel *model in self.dataArray)
    {
        if (model.isCollected)
        {
            [self.collectArray addObject:model];
        }
    }
    [_tableView reloadData];
}

-(void)deCollectArticleWithRow:(NSInteger)row
{
    [self.collectArray removeObjectAtIndex:row];
    [_tableView reloadData];
}

-(void)allBtnClickWithRow:(NSInteger)row
{
    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

@end

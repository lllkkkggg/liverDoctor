//
//  ZDPArticleViewController.m
//  ForYourHealthOne
//
//  Created by iosOne on 16/9/7.
//  Copyright © 2016年 吕盼举. All rights reserved.
//

#import "ZDPArticleViewController.h"
#import "UIViewController+Utility.h"
#import "MyArticleTableViewCell.h"
#import "ZDPDetailViewController.h"

@interface ZDPArticleViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchControllerDelegate,MyArticleTableViewCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)UISearchController *searchController;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property(nonatomic,strong)NSMutableArray *searchResultArray;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,assign)int type;
@property(nonnull,copy)NSString *searchStr;
@end

@implementation ZDPArticleViewController

-(NSMutableArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}


-(NSMutableArray *)searchResultArray
{
    if (!_searchResultArray)
    {
        _searchResultArray = [[NSMutableArray alloc] init];
    }
    return  _searchResultArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    BOOL iOS7 = [UIDevice currentDevice].systemVersion.floatValue >= 7.0;
    if (iOS7)
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [_tableView registerNib:[UINib nibWithNibName:@"MyArticleTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
//    UIView *v = [[UIView alloc] init];
//    [v addConstraint:[NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
//    [v addConstraint:[NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
//    [v addConstraint:[NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
//    [v addConstraint:[NSLayoutConstraint constraintWithItem:v attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:44]];
    //    v.backgroundColor = [UIColor redColor];
    //    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    //    _searchController.searchResultsUpdater = self;
    //    _searchController.dimsBackgroundDuringPresentation = NO;
    //    _searchController.hidesNavigationBarDuringPresentation = NO;
    ////    _searchController.searchBar.frame = CGRectMake(0, 0,  _tableView.frame.size.width, 44);
    //    [_searchController.searchBar sizeToFit];
    //    _searchController.searchBar.delegate = self;
    //    _searchController.searchBar.tintColor = [UIColor colorWithRed:31/255.0 green:185/255.0 blue:34/255.0 alpha:1];
    //    _searchController.searchBar.barTintColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1];
    //    _searchController.searchBar.placeholder = @"搜索";
    //    [v addSubview:self.searchController.searchBar];
    _searchBar.barTintColor = RGBA(230, 230, 230, 0.7);
    _searchBar.placeholder = @"请输入搜索的关键词";
    _searchBar.delegate = self;
    _searchBar.translucent = YES;
//    [v addSubview:self.searchBar];
//    [_searchBar addConstraint:[NSLayoutConstraint constraintWithItem:_searchBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:v attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
//    [_searchBar addConstraint:[NSLayoutConstraint constraintWithItem:_searchBar attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:v attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0]];
//    [_searchBar addConstraint:[NSLayoutConstraint constraintWithItem:_searchBar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:v attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
//    [_searchBar addConstraint:[NSLayoutConstraint constraintWithItem:_searchBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:44]];
//    [self.view addSubview:v];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([LocalFileManager readFromFile])
    {
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:[LocalFileManager readFromFile]];
    }
    if(self.dataArray.count == 0)
    {
        UILabel *l =[[UILabel alloc]init];
        l.translatesAutoresizingMaskIntoConstraints = NO;
        [_tableView addSubview:l];
        l.text = @"暂无数据";
        l.textAlignment = NSTextAlignmentCenter;
        l.tag = 100000;
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:l attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_tableView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:l attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_tableView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    }
    else
    {
        [[_tableView viewWithTag:100000] removeFromSuperview];
    }
    
    if (_type != 1)
    {
        [_tableView reloadData];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_type == 1)
    {
        return self.searchResultArray.count;
    }
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    MyArticleModel *model = nil;
    if (_type == 1)
    {
        model = (MyArticleModel *)self.searchResultArray[indexPath.row];
        cell.searchStr = _searchStr;
    }
    else
    {
        model = (MyArticleModel *)self.dataArray[indexPath.row];
        cell.searchStr = nil;
    }
    [cell configWithArticle:model];
    cell.delegate = self;
    cell.row = indexPath.row;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyArticleModel *model = nil;
    if (_type == 1)
    {
        model = (MyArticleModel *)self.searchResultArray[indexPath.row];
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
    model = (MyArticleModel *)self.dataArray[indexPath.row];
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ZDPDetailViewController *vc = [main instantiateViewControllerWithIdentifier:@"ZDPDetailViewController"];
    vc.titleStr = model.title;
    vc.contentStr = model.content;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [_searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    _type = 1;
    [_tableView reloadData];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    _type = 0;
    [_searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    [_tableView reloadData];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
     [self.searchResultArray removeAllObjects];
    NSString *searchString = searchText;
    _searchStr = searchText;
    if (searchString && searchString.length > 0)
    {
        for (MyArticleModel *tempModel in self.dataArray)
        {
            NSString *title = tempModel.title;
            NSString *content = tempModel.content;
            if ([title rangeOfString:searchString options:NSCaseInsensitiveSearch].length > 0)
            {
                    [self.searchResultArray addObject:tempModel];
            }
            else
            {
                if ([content rangeOfString:searchString options:NSCaseInsensitiveSearch].length > 0)
                {
                    [self.searchResultArray addObject:tempModel];
                }
            }
        }
    }
    [_tableView reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

#pragma mark - MyArticleTableViewCellDelegate
-(void)allBtnClickWithRow:(NSInteger)row
{
    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

@end

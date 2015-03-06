//
//  FirstViewController.m
//  JHCellConfigDemo
//
//  Created by JC_Hu on 15/2/25.
//  Copyright (c) 2015年 JCHu. All rights reserved.
//

#import "FirstViewController.h"
#import "JHCellConfig.h"
#import "UserInfoCell.h"
#import "SimpleCell.h"

@interface FirstViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *mainTableView;

/// cellConfig数据源
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation FirstViewController

#pragma mark - 懒加载

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        
        // 二维数组作为tableView的结构数据源
        _dataArray = [NSMutableArray array];
        
        JHCellConfig *avatar = [JHCellConfig cellConfigWithClassName:NSStringFromClass([UserInfoCell class]) title:@"个人信息" showInfoMethod:@selector(showInfo:) heightOfCell:kHeightOfUserInfo];
        
        [_dataArray addObject:@[avatar]];
        
        
    }
    return _dataArray;
}

#pragma mark - VC lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavBar];
    
    [self addAllViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
}

#pragma mark - Methods
- (void)setNavBar
{
    self.title = @"基本使用";
}

- (void)addAllViews
{
    self.mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:self.mainTableView];
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    
    
}

#pragma mark - TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray[section] count];
}

#pragma mark 设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 拿到cellConfig
    JHCellConfig *cellConfig = self.dataArray[indexPath.section][indexPath.row];
    
    // 拿到对应cell并根据模型显示
    UITableViewCell *cell = [cellConfig cellOfCellConfigWithTableView:tableView dataModel:nil];
    
    return cell;
}

#pragma mark - TableView Delegate
#pragma mark 选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JHCellConfig *cellConfig = self.dataArray[indexPath.section][indexPath.row];
    
    return cellConfig.heightOfCell;
}

#pragma mark Header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}


@end

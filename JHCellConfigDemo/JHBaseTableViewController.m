//
//  JHBaseTableViewController.m
//  JHCellConfigDemo
//
//  Created by JasonHu on 2018/4/20.
//  Copyright © 2018年 JCHu. All rights reserved.
//

#import "JHBaseTableViewController.h"

@interface JHBaseTableViewController ()

@end

@implementation JHBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                      style:[self getTableStyle]];
    self.mainTableView.autoresizingMask =
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mainTableView.separatorStyle = [self getSeparatorStyle];
    self.mainTableView.separatorColor = [self getSeparatorColor];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.backgroundColor = [self getTableViewBackgroundColor];
    
    
    [self.view addSubview:self.mainTableView];
}

- (UITableViewStyle)getTableStyle
{
    return UITableViewStylePlain;
}

- (UITableViewCellSeparatorStyle)getSeparatorStyle
{
    return UITableViewCellSeparatorStyleSingleLine;
}

- (UIColor *)getSeparatorColor
{
    return [UIColor colorWithWhite:.9 alpha:1];
}

- (UIColor *)getTableViewBackgroundColor
{
    return [UIColor whiteColor];
}

#pragma mark - TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataArray.count > section) {
        id object = self.dataArray[section];
        
        if ([object respondsToSelector:@selector(count)]) {
            return [object count];
        }
    }
    NSLog(@"%s - %s, Unexpected, Line %d",__FILE__, __FUNCTION__, __LINE__);
    
    return 0;
}

#pragma mark 设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 拿到cellConfig
    JHCellConfig *cellConfig = self.dataArray[indexPath.section][indexPath.row];
    
    // 拿到对应cell并根据模型显示
    UITableViewCell *cell = [cellConfig cellOfCellConfigWithTableView:tableView];
    
    return cell;
}

#pragma mark - TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JHCellConfig *cellConfig = [self cellConfigOfIndexPath:indexPath];
    
    return [cellConfig cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JHCellConfig *cellConfig = [self cellConfigOfIndexPath:indexPath];
    if (cellConfig.selectBlock) {
        cellConfig.selectBlock(cellConfig, [tableView cellForRowAtIndexPath:indexPath]);
    }
}

#pragma mark -
- (JHCellConfig *)cellConfigOfIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    if (self.dataArray.count > section) {
        
        id object = self.dataArray[section];
        
        if ([object isKindOfClass:[NSArray class]] && [object count] > indexPath.row) {
            return object[indexPath.row];
        }
    }
    return nil;
}

#pragma mark - Lazy Init

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)dealloc
{
    NSLog(@"%s", __FUNCTION__);
}

@end

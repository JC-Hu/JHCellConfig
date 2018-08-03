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
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.mainTableView];
}

- (UITableViewStyle)getTableStyle
{
    return UITableViewStyleGrouped;
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
    if (![self isTwoDimensionalDataArray]) {
        if (self.dataArray.count) {
            return 1;
        } else {
            return 0;
        }
    } else {
        return self.dataArray.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (![self isTwoDimensionalDataArray]) {
        
        return self.dataArray.count;
    } else {
        if (self.dataArray.count > section) {
            id object = self.dataArray[section];
            
            if ([object respondsToSelector:@selector(count)]) {
                return [object count];
            }
        }
    }
    return 0;
}

#pragma mark 设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 拿到cellConfig
    JHCellConfig *cellConfig = [self cellConfigOfIndexPath:indexPath];
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

#pragma mark -
- (JHCellConfig *)cellConfigOfIndexPath:(NSIndexPath *)indexPath
{
    if (![self isTwoDimensionalDataArray]) {
        
        if (self.dataArray.count > indexPath.row) {
            return self.dataArray[indexPath.row];
        }
    } else {
        NSInteger section = indexPath.section;
        if (self.dataArray.count > section) {
            
            id object = self.dataArray[section];
            
            if ([object isKindOfClass:[NSArray class]] && [object count] > indexPath.row) {
                return object[indexPath.row];
            }
        }
    }
    return nil;
}

- (BOOL)isTwoDimensionalDataArray
{
    if (self.dataArray.firstObject && [self.dataArray.firstObject isKindOfClass:[NSArray class]]) {
        return YES;
    }
    return NO;
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

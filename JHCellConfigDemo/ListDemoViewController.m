//
//  ListDemoViewController.m
//  JHCellConfigDemo
//
//  Created by JasonHu on 2018/4/23.
//  Copyright © 2018年 JCHu. All rights reserved.
//

#import "ListDemoViewController.h"

#import "AdvanceCommentCell.h"

#import "DetailDemoViewController.h"
#import "GeneralDetailViewController.h"

@interface ListDemoViewController ()

@property (nonatomic, strong) NSArray *commentDataArray;

@end

@implementation ListDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];    
    
    [self requestNewData];
}

// 获取数据并刷新
- (void)requestNewData
{
    self.commentDataArray = [self generateFakeCommentArray];
    [self reloadData];
}

// 更新UI
- (void)reloadData
{
    [self updateDataArray];
    [self.mainTableView reloadData];
}

// 更新cellConfig数组
- (void)updateDataArray
{
    [self.dataArray removeAllObjects];
    
    for (int i = 0; i < self.commentDataArray.count; i++) {
        JHCellConfig * cellConfig = [self commentListCellWithModel:self.commentDataArray[i]];
        
        [self.dataArray addObject:cellConfig];
    }
}

#pragma mark -
- (JHCellConfig *)commentListCellWithModel:(Comment *)model
{
    JHCellConfig *cellConfig =
    [JHCellConfig cellConfigWithCellClass:[AdvanceCommentCell class]
                                    title:nil
                                dataModel:model
                              selectBlock:^(JHCellConfig *selectCellConfig, UITableViewCell *selectCell)
     {
         // 点击事件
         GeneralDetailViewController *detailVC = [GeneralDetailViewController new];
         detailVC.title = [model.userName stringByAppendingString:@" 的评论详情"];
         
         [self.navigationController pushViewController:detailVC animated:YES];
         
     }];
    return cellConfig;
}

#pragma mark - 
/// 生成假数据数组
- (NSMutableArray *)generateFakeCommentArray
{
    NSMutableArray *array = [NSMutableArray array];
    
    int count = arc4random()%40+20; // 假数据条数
    
    for (int i = 0; i < count; i++) {
        
        Comment *comment = [Comment new];
        
        comment.userName = [NSString stringWithFormat:@"水军%d", i];
        comment.content = [self generateString];
        
        [array addObject:comment];
        
    }
    
    return array;
}


/// 生成长度不定的string
- (NSString *)generateString
{
    int count = arc4random()%15+1;
    
    NSString *string = @"这是一条假数据";
    
    NSString *result = @"";
    
    for (int i = 0; i < count; i++) {
        result = [result stringByAppendingString:string];
    }
    
    return result;
}



#pragma mark - Get
- (NSArray *)commentDataArray
{
    if (!_commentDataArray) {
        _commentDataArray = [NSArray array];
    }
    return _commentDataArray;
}

@end

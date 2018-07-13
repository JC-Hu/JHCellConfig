//
//  DetailDemoViewController.m
//  JHCellConfigDemo
//
//  Created by JasonHu on 2018/4/21.
//  Copyright © 2018年 JCHu. All rights reserved.
//

#import "DetailDemoViewController.h"

#import "AdvanceCommentCell.h"


@interface DetailDemoViewController ()

@property (nonatomic, strong) NSArray *commentDataArray;

@end

@implementation DetailDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.commentDataArray = [self generateFakeCommentArray];
    
    [self updateDataArray];
}


- (void)updateDataArray
{
    [self.dataArray removeAllObjects];
    
    NSMutableArray *commentCellConfigArray = [NSMutableArray array];
    for (int i = 0; i < self.commentDataArray.count; i++) {
        JHCellConfig *cellConfig = [JHCellConfig cellConfigWithCellClass:[AdvanceCommentCell class] dataModel:self.commentDataArray[i]];
        
        [commentCellConfigArray addObject:cellConfig];
    }
    
    [self.dataArray addObject:commentCellConfigArray];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    JHCellConfig *cellConfig = [self cellConfigOfIndexPath:indexPath];
    
    [self.navigationController pushViewController:[DetailDemoViewController new] animated:YES];
}


#pragma mark - 评论假数据生成
/// 生成评论数据数组
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




- (NSArray *)commentDataArray
{
    if (!_commentDataArray) {
        _commentDataArray = [NSArray array];
    }
    return _commentDataArray;
}


@end

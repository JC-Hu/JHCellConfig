//
//  DetailDemoViewController.m
//  JHCellConfigDemo
//
//  Created by JasonHu on 2018/4/21.
//  Copyright © 2018年 JCHu. All rights reserved.
//

#import "DetailDemoViewController.h"

#import "AdvanceCommentCell.h"
#import "Model.h"

#import "BigPhotoCell.h"
#import "BuyInfoCell.h"
#import "CommentCell.h"
#import "SellerInfoCell.h"

@interface DetailDemoViewController ()

/// 数据模型
@property (nonatomic, strong) Model *modelToShow;

@property (nonatomic, strong) NSArray *commentDataArray;


@end

@implementation DetailDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self updateDataArray];
}

- (void)updateDataArray
{
    [self.dataArray removeAllObjects];
    
    // 大图
    [self.dataArray addObject:[self bigPhotoCell]];
    
    // 购买信息
//    JHCellConfig *buyInfo = [JHCellConfig cellConfigWithCellClass:[BuyInfoCell class] dataModel:nil];
//
//    
//    [self.dataArray addObject:buyInfo];

    
    
    //
    //    // 评论
    //    // 要恢复显示这种cell，将下面的代码取消注释，即可。反之，要不显示某种cell，注释即可。其他cell同理
    //
    //    //        JHCellConfig *commentInfo = [JHCellConfig cellConfigWithClassName:NSStringFromClass([CommentCell class]) title:@"评论" showInfoMethod:@selector(showInfo:) heightOfCell:kHeightOfComment];
    //    //
    //    //        [_dataArray addObject:@[commentInfo]];
    //
    //
    for (int i = 0; i < self.commentDataArray.count; i++) {
        JHCellConfig *cellConfig = [JHCellConfig cellConfigWithCellClass:[AdvanceCommentCell class] dataModel:self.commentDataArray[i]];
        
        [self.dataArray addObject:cellConfig];
    }
    
    //
    //
    //    // 商家信息
    //    JHCellConfig *sellerInfo = [JHCellConfig cellConfigWithClassName:NSStringFromClass([SellerInfoCell class]) title:@"商家信息" showInfoMethod:@selector(showInfo:) heightOfCell:kHeightOfSellerInfo];
    //    [self.dataArray addObject:@[sellerInfo]];
    
}

- (JHCellConfig *)bigPhotoCell {
    BigPhotoCellModel *model = [BigPhotoCellModel new];
    model.imageName = self.modelToShow.imageName1;
    
    JHCellConfig *bigPhoto = [JHCellConfig cellConfigWithCellClass:[BigPhotoCell class] dataModel:model];
    return bigPhoto;
}

#pragma mark -
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

- (Model *)modelToShow
{
    if (!_modelToShow) {
        _modelToShow = [Model new];
        // 假数据
        for (int i = 1; i < 5; i++) {
            NSString *key = [NSString stringWithFormat:@"imageName%d",i];
            NSString *value = [NSString stringWithFormat:@"cell_%02d",i];
            
            [_modelToShow setValue:value forKey:key];
        }
    }
    return _modelToShow;
}

@end

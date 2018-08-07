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
#import "BlankCell.h"

@interface DetailDemoViewController ()

/// 数据模型
@property (nonatomic, strong) Model *modelToShow;

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
    
    // 大图
    [self.dataArray addObject:[self bigPhotoCell]];
    // 购买信息
    [self.dataArray addObject:[self buyInfoCell]];
    [self.dataArray addObject:[self blankCellWithHeight:10]];
    
    // 评分评价
    [self.dataArray addObject:[self commentCell]];
    [self.dataArray addObject:[self blankCellWithHeight:10]];
    // 买家信息
    [self.dataArray addObject:[self sellerInfoCell]];
    [self.dataArray addObject:[self blankCellWithHeight:15]];

    //
 
    for (int i = 0; i < self.commentDataArray.count; i++) {
        JHCellConfig *cellConfig = [JHCellConfig cellConfigWithCellClass:[AdvanceCommentCell class] dataModel:self.commentDataArray[i]];
        
        [self.dataArray addObject:cellConfig];
    }
}

- (JHCellConfig *)bigPhotoCell {
    BigPhotoCellModel *model = [BigPhotoCellModel new];
    model.imageName = self.modelToShow.imageName1;
    
    JHCellConfig *bigPhoto = [JHCellConfig cellConfigWithCellClass:[BigPhotoCell class] title:@"大图" dataModel:model];
    bigPhoto.selectBlock = ^(JHCellConfig *selectCellConfig, UITableViewCell *selectCell) {
        // 点击事件
        [self presentViewController:[UIAlertController alertControllerWithTitle:@"点击Cell" message:@"点击了大图" preferredStyle:UIAlertControllerStyleAlert] animated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    };
    return bigPhoto;
}

- (JHCellConfig *)buyInfoCell {
    BigPhotoCellModel *model = [BigPhotoCellModel new];
    model.imageName = self.modelToShow.imageName2;
    
    JHCellConfig *buyInfoCell = [JHCellConfig cellConfigWithCellClass:[BuyInfoCell class] title:@"购买信息" dataModel:model];
    buyInfoCell.selectBlock = ^(JHCellConfig *selectCellConfig, UITableViewCell *selectCell) {
        // 点击事件
        [self presentViewController:[UIAlertController alertControllerWithTitle:@"点击Cell" message:@"点击了购买信息" preferredStyle:UIAlertControllerStyleAlert] animated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    };
    return buyInfoCell;
}

- (JHCellConfig *)commentCell {
    BigPhotoCellModel *model = [BigPhotoCellModel new];
    model.imageName = self.modelToShow.imageName3;
    
    JHCellConfig *commentCell = [JHCellConfig cellConfigWithCellClass:[CommentCell class] title:@"评价" dataModel:model];
    commentCell.selectBlock = ^(JHCellConfig *selectCellConfig, UITableViewCell *selectCell) {
        // 点击事件
        [self presentViewController:[UIAlertController alertControllerWithTitle:@"点击Cell" message:@"点击了评价" preferredStyle:UIAlertControllerStyleAlert] animated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    };
    return commentCell;
}

- (JHCellConfig *)sellerInfoCell {
    BigPhotoCellModel *model = [BigPhotoCellModel new];
    model.imageName = self.modelToShow.imageName4;
    
    JHCellConfig *sellerInfoCell = [JHCellConfig cellConfigWithCellClass:[SellerInfoCell class] title:@"商家信息" dataModel:model];
    sellerInfoCell.selectBlock = ^(JHCellConfig *selectCellConfig, UITableViewCell *selectCell) {
        // 点击事件
        [self presentViewController:[UIAlertController alertControllerWithTitle:@"点击Cell" message:@"点击了商家信息" preferredStyle:UIAlertControllerStyleAlert] animated:YES completion:nil];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    };
    return sellerInfoCell;
}

- (JHCellConfig *)blankCellWithHeight:(CGFloat)height
{
    BlankCellModel *model = [BlankCellModel new];
    model.height = height;
    model.color = [UIColor groupTableViewBackgroundColor];
    
    JHCellConfig *cell = [JHCellConfig cellConfigWithCellClass:[BlankCell class] dataModel:model];
    return cell;
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

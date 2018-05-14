//
//  FirstViewController.m
//  JHCellConfigDemo
//
//  Created by JC_Hu on 15/2/25.
//  Copyright (c) 2015年 JCHu. All rights reserved.
//

#import "FirstViewController.h"
#import "JHCellConfig.h"
#import "BigPhotoCell.h"
#import "BuyInfoCell.h"
#import "CommentCell.h"
#import "SellerInfoCell.h"
#import "GeneralDetailViewController.h"

@interface FirstViewController ()<UITableViewDataSource, UITableViewDelegate>

/// 数据模型
@property (nonatomic, strong) Model *modelToShow;

@end

@implementation FirstViewController

- (void)reloadDataArray
{
    // 二维数组作为tableView的结构数据源
    // 改变不同类型cell的顺序、增删时，只需在此修改即可，无需在多个tableView代理方法中逐个修改
    
    // 大图
//    JHCellConfig *bigPhoto = [JHCellConfig cellConfigWithClassName:NSStringFromClass([BigPhotoCell class]) title:@"大图" showInfoMethod:@selector(showInfo:) heightOfCell:kHeightOfBigPhoto];
//    
//    // 购买信息
//    JHCellConfig *buyInfo = [JHCellConfig cellConfigWithClassName:NSStringFromClass([BuyInfoCell class]) title:@"购买信息" showInfoMethod:@selector(showInfo:) heightOfCell:kHeightOfBuyInfo];
//    
//    [self.dataArray addObject:@[bigPhoto, buyInfo]];
//    
//    // 评论
//    // 要恢复显示这种cell，将下面的代码取消注释，即可。反之，要不显示某种cell，注释即可。其他cell同理
//    
//    JHCellConfig *commentInfo = [JHCellConfig cellConfigWithClassName:NSStringFromClass([CommentCell class]) title:@"评论" showInfoMethod:@selector(showInfo:) heightOfCell:kHeightOfComment];
//    
//    [self.dataArray addObject:@[commentInfo]];
//    
//    // 商家信息
//    JHCellConfig *sellerInfo = [JHCellConfig cellConfigWithClassName:NSStringFromClass([SellerInfoCell class]) title:@"商家信息" showInfoMethod:@selector(showInfo:) heightOfCell:kHeightOfSellerInfo];
//    [self.dataArray addObject:@[sellerInfo]];
}



#pragma mark - VC lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavBar];
    
    [self addAllViews];
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
    UITableViewCell *cell;// = [cellConfig cellOfCellConfigWithTableView:tableView dataModel:self.modelToShow];
    
    return cell;
}

#pragma mark - TableView Delegate
#pragma mark 选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 拿到cellConfig
    JHCellConfig *cellConfig = self.dataArray[indexPath.section][indexPath.row];
    
    NSString *valueString = nil;
    
    
    /**
     *
     * 对不同种cell进行不同设置时，通过 其对应的 cellConfig.title 进行判断。
     *
     * （这样，不论你将dataArray如何修改，插入、删除、改变顺序，都无须再次修改这里的判断）
     *
     */

    if ([cellConfig.title isEqualToString:@"大图"] || [cellConfig.title isEqualToString:@"购买信息"]) {
        
        valueString = @"购买信息";
        
    } else {
        valueString = cellConfig.title;
    }
    
    GeneralDetailViewController *detailVC = [GeneralDetailViewController new];
    
    detailVC.title = valueString;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - 懒加载

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

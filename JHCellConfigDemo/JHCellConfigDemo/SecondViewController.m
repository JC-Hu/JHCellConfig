//
//  SecondViewController.m
//  JHCellConfigDemo
//
//  Created by JC_Hu on 15/2/25.
//  Copyright (c) 2015年 JCHu. All rights reserved.
//

#import "SecondViewController.h"
#import "Model.h"
#import "BigPhotoCell.h"
#import "BuyInfoCell.h"
#import "CommentCell.h"
#import "SellerInfoCell.h"
#import "JHCellConfig.h"
#import "GeneralDetailViewController.h"
#import "AdvanceCommentCell.h"
#import "UIView+Shortcut.h"

@interface SecondViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *mainTableView;

/// cellConfig数据源
@property (nonatomic, strong) NSMutableArray *dataArray;

/// 数据模型
@property (nonatomic, strong) Model *modelToShow;

// -----------------------高级评论相关
/// 评论数据源数组
@property (nonatomic, strong) NSMutableArray *commentDataArray;

/// 评论cellConfig数组
@property (nonatomic, strong) NSMutableArray *commentCellConfigArray;

/// 评论header
@property (nonatomic, strong) UIView *commentHeaderView;

// -----------------------

@end

@implementation SecondViewController

#pragma mark - 懒加载

// -----------------------高级评论相关
// 评论数据源数组
- (NSMutableArray *)commentDataArray
{
    if (!_commentDataArray) {
        _commentDataArray = [NSMutableArray array];
    }
    return _commentDataArray;
}

// 评论cellConfig数组
- (NSMutableArray *)commentCellConfigArray
{
    if (!_commentCellConfigArray) {
        _commentCellConfigArray = [NSMutableArray array];
        
    }
    return _commentCellConfigArray;
}

/// 更新评论cellConfig，评论数据源更新后需调用此方法 **
- (void)updateCommentCellConfig
{
    [self.commentCellConfigArray removeAllObjects];
    
    // 根据数据源数组(self.commentDataArray)的数量生成相同数量的cellConfig，加到self.commentCellConfigArray中
    for (int i = 0; i < self.commentDataArray.count; i++) {
        JHCellConfig *cellConfig = [JHCellConfig cellConfigWithClassName:NSStringFromClass([AdvanceCommentCell class]) title:@"评论" showInfoMethod:@selector(showCommentInfo:) heightOfCell:kMinHeightOfAdvanceComment];
        
        [self.commentCellConfigArray addObject:cellConfig];
    }
}

/// 评论header
- (UIView *)commentHeaderView
{
    if (!_commentHeaderView) {
        
        CGFloat height = 20;
        
        _commentHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWidthOfScreen, height)];
        _commentHeaderView.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kWidthOfScreen - 20, height)];
        [_commentHeaderView addSubview:titleLabel];
        
        titleLabel.text = @"评论";
        titleLabel.textColor = [UIColor darkGrayColor];
        
    }
    
    return _commentHeaderView;
}

// -----------------------

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        
        // 二维数组作为tableView的结构数据源
        
        _dataArray = [NSMutableArray array];
        
        // ####
        // #### 改变不同类型cell的顺序、增删时，只需在此修改即可，
        // #### 无需在多个tableView代理方法中逐个修改 
        // ####
        
        /**
         *
         * className:类名
         * title:标题，可用做cell直观的区分
         * showInfoMethod:此类cell用来显示数据模型的方法， 如@selector(showInfo:)
         * heightOfCell:此类cell的高度
         *
         */
        
        // 大图
        JHCellConfig *bigPhoto = [JHCellConfig cellConfigWithClassName:NSStringFromClass([BigPhotoCell class]) title:@"大图" showInfoMethod:@selector(showInfo:) heightOfCell:kHeightOfBigPhoto];
        
        // 购买信息
        JHCellConfig *buyInfo = [JHCellConfig cellConfigWithClassName:NSStringFromClass([BuyInfoCell class]) title:@"购买信息" showInfoMethod:@selector(showInfo:) heightOfCell:kHeightOfBuyInfo];
        
        [_dataArray addObject:@[bigPhoto, buyInfo]]; // 注意，是self.dataArray二维数组，所以这里要套一层数组
        
        // 评论
        // 要恢复显示这种cell，将下面的代码取消注释，即可。反之，要不显示某种cell，注释即可。其他cell同理
        
        //        JHCellConfig *commentInfo = [JHCellConfig cellConfigWithClassName:NSStringFromClass([CommentCell class]) title:@"评论" showInfoMethod:@selector(showInfo:) heightOfCell:kHeightOfComment];
        //
        //        [_dataArray addObject:@[commentInfo]];
        
        
        // -----------------------高级评论相关
        
        if (self.commentCellConfigArray.count) {
            
            [_dataArray addObject:self.commentCellConfigArray];
        }
        
        // -----------------------
        
        
        // 商家信息
        JHCellConfig *sellerInfo = [JHCellConfig cellConfigWithClassName:NSStringFromClass([SellerInfoCell class]) title:@"商家信息" showInfoMethod:@selector(showInfo:) heightOfCell:kHeightOfSellerInfo];
        [_dataArray addObject:@[sellerInfo]];
    }
    return _dataArray;
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


#pragma mark - VC lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavBar];
    
    [self addAllViews];
    
    [self refresh];
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
    self.title = @"“高级使用”";
    
    // 刷新按钮
    UIBarButtonItem *refreshBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    
    self.navigationItem.rightBarButtonItem = refreshBarButton;
    
}

- (void)addAllViews
{
    self.mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:self.mainTableView];
    
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    
    
}

/// 刷新数据
- (void)refresh
{
    // 更新评论数据
    [self.commentDataArray removeAllObjects];
    [self.commentDataArray addObjectsFromArray:[self generateFakeCommentArray]];
    
    // 更新评论cellConfig
    [self updateCommentCellConfig];
    
    // 刷新TableView
    [self.mainTableView reloadData];
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
    UITableViewCell *cell = nil;
    
    // 特别的设置
    
    // -----------------------高级评论相关
    if ([cellConfig.title isEqualToString:@"评论"]) {
        // 如果是评论cell，则需根据indePath找到self.commentDataArray中的对应数据，让它显示
        cell = [cellConfig cellOfCellConfigWithTableView:tableView dataModel:self.commentDataArray[indexPath.row]];
        
        // 绑定button触发事件
        AdvanceCommentCell *advanceCommentCell = (AdvanceCommentCell *)cell;
        [advanceCommentCell.userNameButton addTarget:self action:@selector(userNameButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        
    } else {
        cell = [cellConfig cellOfCellConfigWithTableView:tableView dataModel:self.modelToShow];
    }
    // -----------------------
    
    // 统一的设置
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JHCellConfig *cellConfig = self.dataArray[indexPath.section][indexPath.row];
    // -----------------------高级评论相关
    if ([cellConfig.title isEqualToString:@"评论"]) {
        
        return [AdvanceCommentCell returnCellHeight: self.commentDataArray[indexPath.row]];
    }
    
    // -----------------------
    return cellConfig.heightOfCell;
}

#pragma mark Header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    // -----------------------高级评论相关
    JHCellConfig *cellConfig = self.dataArray[section][0];
    
    if ([cellConfig.title isEqualToString:@"评论"]) {
        
        return self.commentHeaderView;
    }
    
    // -----------------------
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    // -----------------------高级评论相关
    JHCellConfig *cellConfig = self.dataArray[section][0];

    if ([cellConfig.title isEqualToString:@"评论"]) {
        
        return self.commentHeaderView.height;
    }
    
    // -----------------------
    
    return 0.001;
}

#pragma mark - 按钮触发事件
- (void)userNameButtonAction:(UIButton *)sender
{
    if (sender && [sender respondsToSelector:@selector(superview)]) {
        
        // 根据点击的button找到对应的comment数据模型
        UITableViewCell *cell = (UITableViewCell *)sender.superview.superview;
        
        NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
        
        if (indexPath == nil) {
            // iOS7
            indexPath = [self.mainTableView indexPathForCell:(UITableViewCell *)cell.superview];
        }
        
        Comment *comment = self.commentDataArray[indexPath.row];
        
        // 跳转
        GeneralDetailViewController *detailVC = [GeneralDetailViewController new];
        
        detailVC.title = [NSString stringWithFormat:@"%@ 的资料", comment.userName];
        
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    
    
}

#pragma mark - 评论假数据生成
/// 生成评论数据数组
- (NSMutableArray *)generateFakeCommentArray
{
    NSMutableArray *array = [NSMutableArray array];
    
    int count = arc4random()%10+3; // 假数据条数
    
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


@end

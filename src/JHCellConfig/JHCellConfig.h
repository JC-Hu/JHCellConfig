//
//  JHCellConfig.h
//  JHCellConfigDemo
//
//  Created by JC_Hu on 15/2/25.
//  Copyright (c) 2015年 JCHu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class JHCellConfig;
typedef void(^JHCellSelectBlock)(JHCellConfig *selectCellConfig, UITableViewCell *selectCell);

@protocol JHCellConfigProtocol <NSObject>

@property (nonatomic, strong) JHCellConfig *cellConfig;

- (void)updateContentWithCellConfig:(JHCellConfig *)cellConfig;

@optional
+ (CGFloat)cellHeightWithCellConfig:(JHCellConfig *)cellConfig;

@end


@interface JHCellConfig : NSObject

/**
 #本类相当于将tableView中cell所需的基本信息存储下来，以便放到数组中管理
 #每个CellConfig实例与tableView中想要显示的cell相对应。（但注意，是“想要显示的”cell，由于cell的重用，实际上cell并不会生成那么多）
 
 改变不同类型cell的顺序、增删时，极为方便，
 只需操作数据源数组即可，
 无需在多个tableView代理方法中逐个修改
 */

/// cell类名
@property (nonatomic, strong) NSString *className;

/// 指定重用ID，不赋值则使用类名
@property (nonatomic, strong) NSString *reuseID;

/// 标题 - 如“我的订单”，对不同种cell进行不同设置时，可以通过 其对应的 cellConfig.title 进行判断
@property (nonatomic, strong) NSString *title;

/// 业务数据模型
@property (nonatomic, strong) id dataModel;

/// 显示数据模型的方法
@property (nonatomic, assign) SEL updateContentMethod;
/// 高度计算方法
@property (nonatomic, assign) SEL cellHeightMethod;

/// cell高度(固定高度)
@property (nonatomic, assign) CGFloat constantHeight;
/// 高度缓存
@property (nonatomic, assign) CGFloat cachedHeight;

@property (nonatomic, copy) JHCellSelectBlock selectBlock;

@property (nonatomic, assign) BOOL isNib;



#pragma mark - Core

+ (instancetype)cellConfigWithCellClass:(Class)cellClass
                              dataModel:(id)dataModel;

+ (instancetype)cellConfigWithCellClass:(Class)cellClass
                                  title:(NSString *)title
                              dataModel:(id)dataModel;

+ (instancetype)cellConfigWithCellClass:(Class)cellClass
                                  title:(NSString *)title
                              dataModel:(id)dataModel
                            selectBlock:(JHCellSelectBlock)selectBlock;

/// 根据cellConfig生成cell，重用ID为cell类名
- (UITableViewCell *)cellOfCellConfigWithTableView:(UITableView *)tableView;


/// 获取cell高度
- (CGFloat)cellHeight;
- (JHCellConfig *)useNib;

#pragma mark - Assist
/// 根据类名，快捷注册cell
- (void)registerNibForTableView:(UITableView *)tableView;

@end

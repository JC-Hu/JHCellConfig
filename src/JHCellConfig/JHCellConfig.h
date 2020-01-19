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

@optional
/// 更新界面（可改为自定义的方法，见属性updateContentMethod）
- (void)updateContentWithCellConfig:(JHCellConfig *)cellConfig;
/// 高度获取（可改为自定义的方法，见属性cellHeightMethod）
+ (CGFloat)cellHeightWithCellConfig:(JHCellConfig *)cellConfig;

// 会在生成cell时调用，即cellOfCellConfigWithTableView:方法（如BaseCell定义了属性jhg_cellConfig，即可自动赋值，便于通过cell找到对应的cellConfig）
- (void)setJhg_cellConfig:(JHCellConfig *)cellConfig;

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
/// 是否使用nib文件（建议使用.useNib方法，更简洁）
@property (nonatomic, assign) BOOL isNib;
/// 业务数据模型/或cellModel等，本类只做传值用
@property (nonatomic, strong) id dataModel;
/// tableView didSelectCell时调用
@property (nonatomic, copy) JHCellSelectBlock selectBlock;
/// 对应的tableView，通常用在自适应高度计算时，需手动赋值
@property (nonatomic, weak) UITableView *tableView;

/// 更新界面的方法（默认为协议中的方法，可改为自定义的方法）
@property (nonatomic, assign) SEL updateContentMethod;
/// 高度获取方法（默认为协议中的方法，可改为自定义的方法）
@property (nonatomic, assign) SEL cellHeightMethod;

/// cell固定高度（最优先使用）
@property (nonatomic, assign) CGFloat constantHeight;
/// 高度缓存，需根据需求自行赋值（次于固定高度使用，如不为0，则不执行高度获取方法）
@property (nonatomic, assign) CGFloat cachedHeight;

/// 指定重用ID，不赋值则使用cell类名
@property (nonatomic, strong) NSString *reuseID;

/// 标题 - 如“我的订单”，对不同种cell进行不同设置时，可以通过 其对应的 cellConfig.title 进行判断（加入点击事件后，用处不大）
@property (nonatomic, strong) NSString *title;



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

/// 根据cellConfig生成cell，并调用更新界面方法
- (UITableViewCell *)cellOfCellConfigWithTableView:(UITableView *)tableView;


/// 使用xib，须在生成cell前调用
- (JHCellConfig *)useNib;
/// 根据类名，快捷注册cell
- (JHCellConfig *)registerNib:(UITableView *)tableView;

/// 获取cell高度
- (CGFloat)cellHeight;

@end

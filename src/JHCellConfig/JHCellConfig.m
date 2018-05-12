//
//  JHCellConfig.m
//  JHCellConfigDemo
//
//  Created by JC_Hu on 15/2/25.
//  Copyright (c) 2015年 JCHu. All rights reserved.
//

#import "JHCellConfig.h"

@implementation JHCellConfig

#pragma mark - Core
/**
 * @brief 便利构造器
 *
 * @param className:类名
 * @param title:标题，可用做cell直观的区分
 * @param showInfoMethod:此类cell用来显示数据模型的方法， 如@selector(showInfo:)
 * @param heightOfCell:此类cell的高度
 *
 *
 */
+ (instancetype)cellConfigWithClassName:(NSString *)className
                                  title:(NSString *)title
                         showInfoMethod:(SEL)showInfoMethod
                           heightOfCell:(CGFloat)heightOfCell
{
    JHCellConfig *cellConfig = [JHCellConfig new];
    
    cellConfig.className = className;
    cellConfig.title = title;
    cellConfig.showInfoMethod = showInfoMethod;
    cellConfig.heightOfCell = heightOfCell;
    
    return cellConfig;
}

/// 根据cellConfig生成cell，重用ID为cell类名
- (UITableViewCell *)cellOfCellConfigWithTableView:(UITableView *)tableView
                                         dataModel:(id)dataModel
{
    return [self cellOfCellConfigWithTableView:tableView dataModel:dataModel isNib:NO];
}

/// 根据cellConfig生成cell，重用ID为cell类名,可使用Nib
- (UITableViewCell *)cellOfCellConfigWithTableView:(UITableView *)tableView
                                         dataModel:(id)dataModel
                                             isNib:(BOOL)isNib
{
    Class cellClass = NSClassFromString(self.className);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self cellID]];
    
    if (!cell) {
        
        // 加入使用nib的方法
        if (isNib && self.className.length &&![self.className isEqualToString:@"UITableViewCell"]) {
            NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:self.className owner:nil options:nil];
            
            for (id obj in nibs) {
                if ([obj isKindOfClass: cellClass]) {
                    cell = obj;
                }
            }
            
            if (!cell) {
                NSLog(@"Please Check Nib File About %@", cellClass);
            }
            
        } else {
            cell = [[cellClass?:[UITableViewCell class] alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[self cellID]];
            
        }
    }
    
    // 设置cell
    if (self.showInfoMethod && [cell respondsToSelector:self.showInfoMethod]) {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [cell performSelector:self.showInfoMethod withObject:dataModel];
#pragma clang diagnostic pop
        
    }
    
    return cell;
}


#pragma mark - Dynamic Height
/// 缓存高度
- (CGFloat)heightCachedWithCalculateBlock:(CGFloat (^)(void) )block
{
    if (!self.dynamicHeightOfCell && block) {
        // 没有计算过高度
        // 计算高度并保存
        self.dynamicHeightOfCell = block();
    }
    
    return self.dynamicHeightOfCell;
}

#pragma mark - Assist
/// 根据类名，快捷注册cell
- (void)registerForTableView:(UITableView *)tableView
{
    [tableView registerNib:[UINib nibWithNibName:self.className bundle:nil] forCellReuseIdentifier:[self cellID]];
}

- (NSString *)cellID
{
    if (self.reuseID.length) {
        return self.reuseID;
    }
    return self.className;
}

@end

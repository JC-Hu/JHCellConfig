//
//  JHCellConfig+DynamicHeight.m
//
//  Created by Jason Hu on 2019/1/16.
//

#import "JHCellConfig+DynamicHeight.h"
#import <objc/runtime.h>

@implementation JHCellConfig (DynamicHeight)

/// 简易方法
- (CGFloat)dynamicHeightCalResult
{
    return [self dynamicHeightWithConfiguration:nil identifier:nil usingCache:YES];;
}


/// 完整方法
- (CGFloat)dynamicHeightWithConfiguration:(void (^)(id cell))configuration
                               identifier:(NSString *)identifier
                               usingCache:(BOOL)usingCache
{
    // 高度缓存
    if (usingCache) {
        if (self.cachedHeight > 0) {
            return self.cachedHeight;
        };
    }
    
    CGFloat height = [self dynamicHeightWithConfiguration:configuration identifier:identifier];
    
    if (usingCache) {
            self.cachedHeight = height;
    }
    
    return height;
}

/// 高度计算
- (CGFloat)dynamicHeightWithConfiguration:(void (^)(id cell))configuration
                               identifier:(NSString *)identifier
{
    UITableView *tableView = self.tableView;
    NSAssert(tableView, @"need tableView. Call ’cellConfig.tableView = yourTableView‘ before height calculation");
    
    UITableViewCell *cell = [self templateCellForTableView:tableView identifier:identifier];
    
    // Manually calls to ensure consistent behavior with actual cells (that are displayed on screen).
    [cell prepareForReuse];
    
    // Customize and provide content for our template cell.
    if ([cell respondsToSelector:@selector(updateContentWithCellConfig:)]) {
        [(id<JHCellConfigProtocol>)cell updateContentWithCellConfig:self];
    }
    
    if (configuration) {
        configuration(cell);
    }
    
    CGFloat contentViewWidth = CGRectGetWidth(tableView.frame);
    
    // If a cell has accessory view or system accessory type, its content view's width is smaller
    // than cell's by some fixed values.
    if (cell.accessoryView) {
        contentViewWidth -= 16 + CGRectGetWidth(cell.accessoryView.frame);
    } else {
        static const CGFloat systemAccessoryWidths[] = {
            [UITableViewCellAccessoryNone] = 0,
            [UITableViewCellAccessoryDisclosureIndicator] = 34,
            [UITableViewCellAccessoryDetailDisclosureButton] = 68,
            [UITableViewCellAccessoryCheckmark] = 40,
            [UITableViewCellAccessoryDetailButton] = 48
        };
        contentViewWidth -= systemAccessoryWidths[cell.accessoryType];
    }
    
    CGSize fittingSize = CGSizeZero;
    
    if (@available(iOS 8.0,*)) {
        fittingSize = [cell.contentView systemLayoutSizeFittingSize:CGSizeMake(contentViewWidth, 0) withHorizontalFittingPriority:UILayoutPriorityRequired verticalFittingPriority:UILayoutPriorityFittingSizeLevel];
        
    } else {
        cell.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        NSLayoutConstraint *tempWidthConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:contentViewWidth];
        [cell.contentView addConstraint:tempWidthConstraint];
        fittingSize = [cell.contentView  systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        [cell.contentView removeConstraint:tempWidthConstraint];
    }
    
    
    //    }
    
    // Add 1px extra space for separator line if needed, simulating default UITableViewCell.
    
    if (tableView.separatorStyle != UITableViewCellSeparatorStyleNone) {
        fittingSize.height += 1.0 / [UIScreen mainScreen].scale;
    }
    
    return fittingSize.height;
    
}


#pragma mark -
- (id)templateCellForTableView:(UITableView *)tableView
                    identifier:(NSString *)identifier
{
    NSString *cacheID = identifier.length > 0 ? identifier : self.className;
    
    
    NSMutableDictionary *templateCellsByIdentifiers = objc_getAssociatedObject(self, _cmd);
    if (!templateCellsByIdentifiers) {
        templateCellsByIdentifiers = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, templateCellsByIdentifiers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    
    UITableViewCell *templateCell = templateCellsByIdentifiers[cacheID];
    
    if (!templateCell) {
        templateCell = [self cellOfCellConfigWithTableView:tableView];
        templateCellsByIdentifiers[cacheID] = templateCell;
        //        [self fd_debugLog:[NSString stringWithFormat:@"layout cell created - %@", identifier]];
    }
    
    return templateCell;
}



@end

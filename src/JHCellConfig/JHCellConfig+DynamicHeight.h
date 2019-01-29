//
//  JHCellConfig+DynamicHeight.h
//
//  Created by Jason Hu on 2019/1/16.
//

// 参照FDTemplateLayoutCell，结合JHCellConfig进行了优化
// 可根据约束自动计算cell高度（须添加完整的约束，不了解请参考https://github.com/forkingdog/UITableView-FDTemplateLayoutCell）

#import "JHCellConfig.h"

@interface JHCellConfig (DynamicHeight)

/// 简易方法
- (CGFloat)dynamicHeightCalResult;

/// 完整方法
- (CGFloat)dynamicHeightWithConfiguration:(void (^)(id cell))configuration
                               identifier:(NSString *)identifier
                               usingCache:(BOOL)usingCache;

@end


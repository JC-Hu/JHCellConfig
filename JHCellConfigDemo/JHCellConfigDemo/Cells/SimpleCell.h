//
//  SimpleCell.h
//  JHCellConfigDemo
//
//  Created by JC_Hu on 15/2/25.
//  Copyright (c) 2015年 JCHu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleCell : UITableViewCell

/// 根据数据模型显示信息
- (void)showInfo:(NSDictionary *)dict;

@end

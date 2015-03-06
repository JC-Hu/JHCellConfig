//
//  UserInfoCell.m
//  JHCellConfigDemo
//
//  Created by JC_Hu on 15/2/25.
//  Copyright (c) 2015年 JCHu. All rights reserved.
//

#import "UserInfoCell.h"

@implementation UserInfoCell

#pragma mark - 懒加载



#pragma mark - LayoutSubviews
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

/// 根据数据模型显示信息
- (void)showInfo:(User *)user
{
    
    
    [self layoutSubviews];
}

@end

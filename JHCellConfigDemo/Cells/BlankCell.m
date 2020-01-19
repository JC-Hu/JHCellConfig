//
//  BlankCell.m
//  JHCellConfigDemo
//
//  Created by Jason Hu on 2018/8/7.
//  Copyright © 2018年 JCHu. All rights reserved.
//

#import "BlankCell.h"

@implementation BlankCell

// 添加视图
- (void)setupViews
{
    
}

// 布局
- (void)setupConstraints
{
}

- (void)updateContentWithCellConfig:(JHCellConfig *)cellConfig
{
    BlankCellModel *model = self.jhg_cellConfig.dataModel;
    
    self.contentView.backgroundColor = model.color;
}

+ (CGFloat)cellHeightWithCellConfig:(JHCellConfig *)cellConfig
{
    BlankCellModel *model = cellConfig.dataModel;
    
    return model.height;
}

@end

@implementation BlankCellModel


@end

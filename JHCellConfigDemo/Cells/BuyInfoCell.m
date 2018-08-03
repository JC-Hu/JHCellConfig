//
//  BuyInfoCell.m
//  JHCellConfigDemo
//
//  Created by JC_Hu on 15/3/9.
//  Copyright (c) 2015年 JCHu. All rights reserved.
//

#import "BuyInfoCell.h"

@implementation BuyInfoCell


#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.mainImageView.frame = CGRectMake(0, 0, kWidthOfScreen, kHeightOfBuyInfo);
    
}

#pragma mark - 显示数据
- (void)showInfo:(Model *)model
{
    self.mainImageView.image = [UIImage imageNamed:model.imageName2];
    
    [self layoutSubviews];
}

#pragma mark - 懒加载
- (UIImageView *)mainImageView
{
    if (!_mainImageView) {
        _mainImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_mainImageView];
    }
    return _mainImageView;
}


@end

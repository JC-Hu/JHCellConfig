//
//  BigPhotoCell.m
//  JHCellConfigDemo
//
//  Created by JC_Hu on 15/3/9.
//  Copyright (c) 2015年 JCHu. All rights reserved.
//

#import "BigPhotoCell.h"

@implementation BigPhotoCell

// 添加视图
- (void)setupViews
{
    [self.contentView addSubview:self.mainImageView];
}

// 布局
- (void)setupConstraints
{
    [self.mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView);
    }];
}

- (void)updateContentWithCellConfig:(JHCellConfig *)cellConfig
{
    BigPhotoCellModel *model = self.cellConfig.dataModel;
    
    self.mainImageView.image = [UIImage imageNamed:model.imageName];
    
//    self.xxxLabel.text = model.xxx;
    
}

+ (CGFloat)cellHeightWithCellConfig:(JHCellConfig *)cellConfig
{
    // 计算并返回高度
    BigPhotoCellModel *model = cellConfig.dataModel;
    CGSize imageSize = [UIImage imageNamed:model.imageName].size;
    
    return imageSize.height/imageSize.width *kWidthOfScreen;
}

#pragma mark - 懒加载
- (UIImageView *)mainImageView
{
    if (!_mainImageView) {
        _mainImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    }
    return _mainImageView;
}
@end

@implementation BigPhotoCellModel


@end

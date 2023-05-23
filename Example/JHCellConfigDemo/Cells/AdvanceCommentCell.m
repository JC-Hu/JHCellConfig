//
//  AdvanceCommentCell.m
//  JHCellConfigDemo
//
//  Created by JC_Hu on 15/3/21.
//  Copyright (c) 2015年 JCHu. All rights reserved.
//

#import "AdvanceCommentCell.h"
#import "Macro.h"
#import "UIView+Shortcut.h"


#define kHeightMinOfContent 20 // contentLabel最小高度

#define kSpace 20
#define kWidthOfContent kWidthOfScreen - 2*kSpace

#define kSizeOfLabelFont 12

@implementation AdvanceCommentCell


// 添加视图
- (void)setupViews
{
    [self.contentView addSubview:self.userNameButton];
    [self.contentView addSubview:self.contentLabel];
}

// 布局
- (void)setupConstraints
{
    [self.userNameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(kSpace);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userNameButton);
        make.top.mas_equalTo(self.userNameButton.mas_bottom).mas_offset(kSpace/2.0);
        make.bottom.mas_lessThanOrEqualTo(-kSpace);
        make.right.mas_lessThanOrEqualTo(-kSpace);
    }];
    
}

/// 根据数据模型来显示内容
- (void)updateContentWithCellConfig:(JHCellConfig *)cellConfig
{
    Comment *comment = cellConfig.dataModel;
    
    [self.userNameButton setTitle:comment.userName forState:UIControlStateNormal];
    
    self.contentLabel.text = comment.content;
}

// 返回cell高度
+ (CGFloat)cellHeightWithCellConfig:(JHCellConfig *)cellConfig
{
    // 自动计算
    return [cellConfig dynamicHeightCalResult]; // 简易方法,会自动缓存计算结果
    
    // 完整方法
//    return [cellConfig dynamicHeightWithConfiguration:^(id cell) {
//        // 在此block可在高度计算前对cell进行操作，会在updateContentWithCellConfig:后执行
//        // do something
//    }
//                                           identifier:nil // 指定reuseId，默认为cell类名
//                                           usingCache:NO];// 可设置为不缓存计算结果
    
}

- (UIButton *)userNameButton
{
    if (!_userNameButton) {
        _userNameButton = [UIButton buttonWithType:UIButtonTypeSystem];
        
        _userNameButton.titleLabel.textColor = [UIColor colorWithRed:90 / 255.0 green:125 / 255.0 blue:179 / 255.0 alpha:1];
    }
    return _userNameButton;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        
        _contentLabel.textColor = [UIColor grayColor];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:kSizeOfLabelFont];
        
    }
    return _contentLabel;
}


@end

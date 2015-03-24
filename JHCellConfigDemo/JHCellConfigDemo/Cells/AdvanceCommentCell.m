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

- (UIButton *)userNameButton
{
    if (!_userNameButton) {
        _userNameButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.contentView addSubview:_userNameButton];
        
        _userNameButton.titleLabel.textColor = [UIColor colorWithRed:90 / 255.0 green:125 / 255.0 blue:179 / 255.0 alpha:1];
    }
    return _userNameButton;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_contentLabel];
        
        _contentLabel.textColor = [UIColor grayColor];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont systemFontOfSize:kSizeOfLabelFont];
    
    }
    return _contentLabel;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.userNameButton.frame = CGRectMake(kSpace, kSpace, 50, 20);
    
    
    CGFloat height = [[self class] HeightForText:self.contentLabel.text];

    self.contentLabel.frame = CGRectMake(self.userNameButton.left, self.userNameButton.bottom + kSpace/2, kWidthOfContent, height);
    
}

/// 根据数据模型来显示内容
- (void)showCommentInfo:(Comment *)comment
{
//    self.textLabel.text = comment.userName;
    
    [self.userNameButton setTitle:comment.userName forState:UIControlStateNormal];
    
    self.contentLabel.text = comment.content;
    
    [self layoutSubviews];
}

/// 返回Cell高度
+ (CGFloat)returnCellHeight:(Comment *)comment
{
    // 固定高度
    CGFloat fixedHeight = kMinHeightOfAdvanceComment - kHeightMinOfContent;
    CGFloat changeHeight = [self HeightForText:comment.content];
//        if (comment.photos.count != 0) {
//            fixedHeight = 77.0;
//        } else {
    if (changeHeight < kHeightMinOfContent) {
        changeHeight = kHeightMinOfContent;
    }
//        }

    return fixedHeight + changeHeight;
}

/// 计算内容文本的高度方法
+ (CGFloat)HeightForText:(NSString *)text
{
    NSDictionary *dict = @{NSFontAttributeName: [UIFont systemFontOfSize:kSizeOfLabelFont]};
    CGSize size = CGSizeMake(kWidthOfContent, 2000);
    CGRect frame = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return frame.size.height;
}
@end

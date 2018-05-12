//
//  AdvanceCommentCell.h
//  JHCellConfigDemo
//
//  Created by JC_Hu on 15/3/21.
//  Copyright (c) 2015年 JCHu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Macro.h"
#import "Comment.h"

#define kMinHeightOfAdvanceComment 80   // 这里可以给一个最小高度，实际上不会被直接使用

@interface AdvanceCommentCell : UITableViewCell

@property (nonatomic, strong) UIButton *userNameButton;

@property (nonatomic, strong) UILabel *contentLabel;


/// 根据数据模型来显示内容
- (void)showCommentInfo:(Comment *)comment;

/// 返回Cell高度
+ (CGFloat)returnCellHeight:(Comment *)comment;
@end

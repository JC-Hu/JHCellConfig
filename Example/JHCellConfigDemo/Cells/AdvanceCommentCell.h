//
//  AdvanceCommentCell.h
//  JHCellConfigDemo
//
//  Created by JC_Hu on 15/3/21.
//  Copyright (c) 2015年 JCHu. All rights reserved.
//

#import "JHBaseCell.h"
#import "Comment.h"

#define kMinHeightOfAdvanceComment 80   // 这里可以给一个最小高度，实际上不会被直接使用

@interface AdvanceCommentCell : JHBaseCell

@property (nonatomic, strong) UIButton *userNameButton;

@property (nonatomic, strong) UILabel *contentLabel;

@end

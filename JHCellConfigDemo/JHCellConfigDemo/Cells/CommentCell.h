//
//  CommentCell.h
//  JHCellConfigDemo
//
//  Created by JC_Hu on 15/3/9.
//  Copyright (c) 2015年 JCHu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Model.h"
#import "Macro.h"

#define kHeightOfComment 214

@interface CommentCell : UITableViewCell

@property (nonatomic, strong) UIImageView *mainImageView;

/// 根据数据模型来显示内容
- (void)showInfo:(Model *)model;

@end

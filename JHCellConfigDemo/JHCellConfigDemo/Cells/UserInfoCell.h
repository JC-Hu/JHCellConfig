//
//  UserInfoCell.h
//  JHCellConfigDemo
//
//  Created by JC_Hu on 15/2/25.
//  Copyright (c) 2015年 JCHu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

#define kHeightOfUserInfo 100

@interface UserInfoCell : UITableViewCell

@property (nonatomic, strong) UIImageView *mainImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *idLabel;

/// 根据数据模型显示信息
- (void)showInfo:(User *)user;

@end

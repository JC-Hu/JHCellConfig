//
//  JHBaseCell.h
//  JHCellConfigDemo
//
//  Created by JasonHu on 2018/4/21.
//  Copyright © 2018年 JCHu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JHCellConfig.h"
#import "Masonry.h"
#import "UIView+Shortcut.h"
#import "Macro.h"

@interface JHBaseCell : UITableViewCell <JHCellConfigProtocol>

@property (nonatomic, strong) JHCellConfig *cellConfig;

- (void)setupViews;
- (void)setupConstraints;

@end

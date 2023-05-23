//
//  JHBaseTableViewController.h
//  JHCellConfigDemo
//
//  Created by JasonHu on 2018/4/20.
//  Copyright © 2018年 JCHu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JHCellConfig.h"
#import "UIView+Shortcut.h"
#import "JHBaseCell.h"

@interface JHBaseTableViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UITableView *mainTableView;

- (UITableViewStyle)getTableStyle;
- (UITableViewCellSeparatorStyle)getSeparatorStyle;
- (UIColor *)getSeparatorColor;


- (JHCellConfig *)cellConfigOfIndexPath:(NSIndexPath *)indexPath;


@end

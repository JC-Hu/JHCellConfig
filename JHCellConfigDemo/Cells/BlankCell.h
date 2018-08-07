//
//  BlankCell.h
//  JHCellConfigDemo
//
//  Created by Jason Hu on 2018/8/7.
//  Copyright © 2018年 JCHu. All rights reserved.
//

#import "JHBaseCell.h"

@interface BlankCell : JHBaseCell

@end

@interface BlankCellModel : NSObject

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) UIColor *color;

@end

//
//  JHBaseCell.m
//  JHCellConfigDemo
//
//  Created by JasonHu on 2018/4/21.
//  Copyright © 2018年 JCHu. All rights reserved.
//

#import "JHBaseCell.h"



@implementation JHBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)updateContentWithCellConfig:(JHCellConfig *)cellConfig
{
    
}



@end

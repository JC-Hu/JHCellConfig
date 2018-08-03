//
//  BigPhotoCell.h
//  JHCellConfigDemo
//
//  Created by JC_Hu on 15/3/9.
//  Copyright (c) 2015年 JCHu. All rights reserved.
//

#import "JHBaseCell.h"

#import "Model.h"

@interface BigPhotoCell : JHBaseCell

@property (nonatomic, strong) UIImageView *mainImageView;

@end

@interface BigPhotoCellModel : NSObject

@property (nonatomic, strong) NSString *imageName;

@end

//
//  SecondViewController.m
//  JHCellConfigDemo
//
//  Created by JC_Hu on 15/2/25.
//  Copyright (c) 2015年 JCHu. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

#pragma mark - VC lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavBar];
    
    [self addAllViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    
}

#pragma mark - Methods
- (void)setNavBar
{
    self.title = @"敬请期待";
}

- (void)addAllViews
{
    
    
}

@end

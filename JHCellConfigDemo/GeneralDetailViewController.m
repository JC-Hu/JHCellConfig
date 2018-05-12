//
//  GeneralDetailViewController.m
//  JHCellConfigDemo
//
//  Created by JC_Hu on 15/3/17.
//  Copyright (c) 2015年 JCHu. All rights reserved.
//

#import "GeneralDetailViewController.h"

@interface GeneralDetailViewController ()

@property (strong, nonatomic) IBOutlet UILabel *detailLabel;

@end

@implementation GeneralDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.detailLabel.text = self.title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

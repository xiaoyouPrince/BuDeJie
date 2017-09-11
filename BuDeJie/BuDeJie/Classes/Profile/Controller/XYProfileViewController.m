//
//  XYProfileViewController.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/8.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "XYProfileViewController.h"

@interface XYProfileViewController ()

@end

@implementation XYProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航条
    [self setupNavBar];
    
}

- (void)setupNavBar
{
    // 左边按钮
    
    // 设置
    UIBarButtonItem *settingItem =  [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(setting)];
    
    // 夜间模型
    UIBarButtonItem *nightItem =  [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"mine-moon-icon"] selImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(night:)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,nightItem];
    
    // titleView
    self.navigationItem.title = @"我的";
    
}

- (void)night:(UIButton *)button
{
    button.selected = !button.selected;
    
}

- (void)setting
{
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}



@end

//
//  XYFriendTrendViewController.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/8.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "XYFriendTrendViewController.h"
#import "XYLoginAndRegistViewController.h"
#import "XYTextField.h"

@interface XYFriendTrendViewController ()

@end

@implementation XYFriendTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavBar];
}

- (void)setupNavBar
{
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"friendsRecommentIcon"] highImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] target:self action:@selector(friendsRecomment)];
    
    // titleView
    self.navigationItem.title = @"我的关注";
    
}

// 推荐关注
- (void)friendsRecomment
{
    
}


/**
 点击登录注册按钮
 */
- (IBAction)clickLoginAndRegister:(id)sender {
    
    /// 进入对应的列表页面
    XYLoginAndRegistViewController *loginVC = [XYLoginAndRegistViewController new];
    [self presentViewController:loginVC animated:YES completion:nil];

    
}

@end

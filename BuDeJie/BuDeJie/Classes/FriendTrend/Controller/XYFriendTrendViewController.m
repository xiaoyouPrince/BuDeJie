//
//  XYFriendTrendViewController.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/8.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "XYFriendTrendViewController.h"

@interface XYFriendTrendViewController ()

@end

@implementation XYFriendTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor greenColor];
    
    
    /// 这里需要判断是否登录状态进行展示对应的页面
    
    
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
    
    
}

@end

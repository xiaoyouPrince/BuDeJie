//
//  XYLoginAndRegistViewController.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/13.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "XYLoginAndRegistViewController.h"
#import "XYLoginView.h"
#import "XYFastLoginView.h"

@interface XYLoginAndRegistViewController ()

@property (weak, nonatomic) IBOutlet UIView *midView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *midViewLeadingCons;
@property (weak, nonatomic) IBOutlet UIView *bottomView;


@end

@implementation XYLoginAndRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 中部添加inputVIew
    XYLoginView *loginView = [XYLoginView loginView];
    [_midView addSubview:loginView];
    
    XYLoginView *registerView = [XYLoginView registerView];
    [_midView addSubview:registerView];
    
    // 底部添加三方登录
    XYFastLoginView *fastView = [XYFastLoginView fastView];
    [_bottomView addSubview:fastView];
    
}

/// 在这里布局 subViews 比在 viewDidLoad 中更加准确。
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // middle
    const CGFloat loginViewW = _midView.xy_width * 0.5;
    
    XYLoginView *loginView = _midView.subviews.firstObject;
    loginView.frame = CGRectMake(0, 10, loginViewW, loginView.frame.size.height);
    
    XYLoginView *registerView = _midView.subviews.lastObject;
    registerView.frame = CGRectMake(loginViewW, 10, loginViewW, loginView.frame.size.height);
    
    // bottom
    XYFastLoginView *fastView = _bottomView.subviews.firstObject;
    fastView.frame = CGRectMake(0, 0, ScreenW , 150);
}

- (IBAction)closeBtnClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)changeLoginAndRegisterBtnClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    _midViewLeadingCons.constant = _midViewLeadingCons.constant == 0 ? -_midView.xy_width * 0.5 : 0;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];

}


@end

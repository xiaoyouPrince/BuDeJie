//
//  XYLoginAndRegistViewController.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/13.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "XYLoginAndRegistViewController.h"
#import "XYLoginView.h"

@interface XYLoginAndRegistViewController ()

@property (weak, nonatomic) IBOutlet UIView *midView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *midViewLeadingCons;


@end

@implementation XYLoginAndRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    XYLoginView *loginView = [XYLoginView loginView];
    [_midView addSubview:loginView];
    
    XYLoginView *registerView = [XYLoginView registerView];
    [_midView addSubview:registerView];
}

/// 在这里布局 subViews 比在 viewDidLoad 中更加准确。
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    const CGFloat loginViewW = _midView.xy_width * 0.5;
    
    XYLoginView *loginView = _midView.subviews.firstObject;
    loginView.frame = CGRectMake(0, 10, loginViewW, loginView.frame.size.height);
    
    XYLoginView *registerView = _midView.subviews.lastObject;
    registerView.frame = CGRectMake(loginViewW, 10, loginViewW, loginView.frame.size.height);
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

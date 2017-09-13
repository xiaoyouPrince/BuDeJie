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


@end

@implementation XYLoginAndRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    XYLoginView *loginView = [[NSBundle mainBundle] loadNibNamed:@"XYLoginView" owner:nil options:nil].firstObject;
    loginView.frame = CGRectMake(0, 10, ScreenW, loginView.frame.size.height);
    [_midView addSubview:loginView];
}

- (IBAction)closeBtnClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)changeLoginAndRegisterBtnClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;

}


@end

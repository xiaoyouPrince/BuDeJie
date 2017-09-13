//
//  XYLoginView.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/13.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "XYLoginView.h"

@interface XYLoginView ()


@end

@implementation XYLoginView


+ (instancetype)loginView{
    
    return [[NSBundle mainBundle] loadNibNamed:@"XYLoginView" owner:nil options:nil].firstObject;
    
}

+ (instancetype)registerView{
    return [[NSBundle mainBundle] loadNibNamed:@"XYLoginView" owner:nil options:nil].lastObject;
}



- (IBAction)loginBtnCLick:(id)sender {
}

- (IBAction)forgetPassBtnClick:(id)sender {
}

@end

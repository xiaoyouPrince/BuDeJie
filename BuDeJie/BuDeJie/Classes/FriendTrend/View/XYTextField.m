//
//  XYTextField.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/13.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "XYTextField.h"

@implementation XYTextField

/*
    1. 光标变成白色
    2. 站位文字颜色变成白色
 */

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.tintColor = [UIColor whiteColor];
    
    [self addTarget:self action:@selector(beginEditing) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(endEditing) forControlEvents:UIControlEventEditingDidEnd];
    
}

- (void)beginEditing
{
//    NSMutableDictionary *attrs = [NSMutableDictionary new];
//    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
    
    
//    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
//    placeholderLabel.textColor = [UIColor greenColor];
    
    [self setPlaceholderColor:[UIColor whiteColor]];
}

- (void)endEditing
{
//    NSMutableDictionary *attrs = [NSMutableDictionary new];
//    attrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
    [self setPlaceholderColor:[UIColor lightGrayColor]];
}


@end

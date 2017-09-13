//
//  UITextField+XYAdd.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/13.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "UITextField+XYAdd.h"

@implementation UITextField (XYAdd)

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    placeholderLabel.textColor = placeholderColor;
}

- (UIColor *)placeholderColor
{
    return nil;
}

@end

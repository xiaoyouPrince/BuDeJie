//
//  NSString+XYAdd.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/10/13.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "NSString+XYAdd.h"

@implementation NSString (XYAdd)

/**
 根据 String 字号和最大宽度计算 String 最终 CGRect
 
 @param width 最大宽度
 @param fontSize 字号
 @return String 最终 CGRect
 */
- (CGRect)xy_boundingRectWithMaxWidth:(CGFloat)width fontSize:(CGFloat)fontSize
{
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    NSDictionary *attrs = @{ NSFontAttributeName : [UIFont systemFontOfSize:fontSize]};
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil];
}

@end

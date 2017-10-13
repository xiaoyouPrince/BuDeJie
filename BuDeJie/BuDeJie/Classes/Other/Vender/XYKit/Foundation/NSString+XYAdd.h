//
//  NSString+XYAdd.h
//  BuDeJie
//
//  Created by 渠晓友 on 2017/10/13.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XYAdd)

/**
 根据 String 字号和最大宽度计算 String 最终 CGRect

 @param width 最大宽度
 @param fontSize 字号
 @return String 最终 CGRect
 */
- (CGRect)xy_boundingRectWithMaxWidth:(CGFloat)width fontSize:(CGFloat)fontSize;

@end

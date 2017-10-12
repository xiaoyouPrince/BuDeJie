//
//  XYTopic.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/10/10.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "XYTopic.h"

@implementation XYTopic

//自己计算 cellHeight 并保存返回
- (CGFloat)cellHeight
{
    // 如果已经计算过，就直接返回
    if (_cellHeight) return _cellHeight;
    
    // 文字的Y值
    _cellHeight += 55;
    
    CGFloat margin = 10;
    
    // 文字的高度
    CGSize textMaxSize = CGSizeMake(ScreenW - 2 * margin, MAXFLOAT);
    _cellHeight += [self.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height + margin;
    
    // 工具条
    _cellHeight += 35 + margin;
    
    return _cellHeight;
}

@end

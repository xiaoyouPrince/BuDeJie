//
//  XYFastLoginView.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/13.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "XYFastLoginView.h"

@implementation XYFastLoginView

+ (instancetype)fastView
{
    return [[NSBundle mainBundle] loadNibNamed:@"XYFastLoginView" owner:nil options:nil].firstObject;
}
@end

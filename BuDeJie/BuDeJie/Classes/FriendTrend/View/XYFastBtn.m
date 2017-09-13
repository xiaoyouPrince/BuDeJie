//
//  XYFastBtn.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/13.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "XYFastBtn.h"

@implementation XYFastBtn

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.xy_y = 0;
    self.imageView.xy_centerX = self.xy_width * 0.5;
    
    self.titleLabel.xy_y = self.imageView.xy_height + 3;
    [self.titleLabel sizeToFit]; // 先适应size 之后在修改centerX
    self.titleLabel.xy_centerX = self.xy_width * 0.5;

}


@end

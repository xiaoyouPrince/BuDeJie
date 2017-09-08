//
//  UIImage+XYAdd.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/9.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "UIImage+XYAdd.h"

@implementation UIImage (XYAdd)

/// 根据图片名返回渲染的原图<XIB中可以复选UIImage选择渲染原图>
+ (UIImage *)imageOriginalWithName:(NSString *)imageName{
    
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end

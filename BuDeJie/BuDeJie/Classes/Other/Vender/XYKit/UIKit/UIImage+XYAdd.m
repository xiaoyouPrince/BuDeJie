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


+ (UIImage *)imageWithName:(NSString *)name
{
    if (iOS7) {
        // 如果是iOS7 拼接图片
        NSString *newName = [name stringByAppendingString:@"_os7"];
        UIImage *image = [UIImage imageNamed:newName];
        
        if (image == nil) {
            // 如果没有 iOS7 的图片就用原来图片名
            image = [UIImage imageNamed:name];
        }
        // 返回该图片
        return image;
    }
    
    // 非iOS7
    return [UIImage imageNamed:name];
}

+ (UIImage *)resiedImageWithName:(NSString *)name
{
    return [self resiedImageWithName:name left:0.5 top:0.5];
}

+ (UIImage *)resiedImageWithName:(NSString *)name left:(CGFloat )left top:(CGFloat)top
{
    UIImage *image = [self imageWithName:name];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}

@end

//
//  UIImage+XYAdd.h
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/9.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XYAdd)


/**
 根据图片名返回渲染的原图

 @param imageName 图片名
 @return 渲染的原图
 */
+ (UIImage *)imageOriginalWithName:(NSString *)imageName;

@end

//
//  UIBarButtonItem+XYAdd.h
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/12.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (XYAdd)

// 快速创建UIBarButtonItem
+ (UIBarButtonItem *)itemWithimage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithimage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action;

@end

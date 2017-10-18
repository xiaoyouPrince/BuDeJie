//
//  UIImageView+XYAdd.h
//  BuDeJie
//
//  Created by 渠晓友 on 2017/10/17.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (XYAdd)


- (void)xy_setOriginImage:(NSString *)originImageURL thumbnailImage:(NSString *)thumbnailImageURL placeholder:(UIImage *)placeholder;

- (void)xy_setHeader:(NSString *)headerUrl;


@end

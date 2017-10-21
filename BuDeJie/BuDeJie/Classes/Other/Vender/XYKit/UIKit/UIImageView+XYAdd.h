//
//  UIImageView+XYAdd.h
//  BuDeJie
//
//  Created by 渠晓友 on 2017/10/17.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

// 本类严重依赖 AFNetWorking 和 SDwebimage

#import <UIKit/UIKit.h>
//#import <UIImageView+WebCache.h>
#import <FLAnimatedImageView+WebCache.h>
/**
 一种返回完成的类型
 */
typedef void(^SDImageDownloadCompletedBlock)(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL);

@interface UIImageView (XYAdd)


/**
 设置原图、缩略图、占位图。内部会根据网络状态和缓存做对应处理

 @param originImageURL 原图URL
 @param thumbnailImageURL 缩略图URL
 @param placeholder 占位图
 */
- (void)xy_setOriginImage:(NSString *)originImageURL thumbnailImage:(NSString *)thumbnailImageURL placeholder:(UIImage *)placeholder;


/**
 设置原图、缩略图、占位图。内部会根据网络状态和缓存做对应处理
 
 @param originImageURL 原图URL
 @param thumbnailImageURL 缩略图URL
 @param placeholder 占位图
 @param completed 下载完成后的回调
 */
- (void)xy_setOriginImage:(NSString *)originImageURL thumbnailImage:(NSString *)thumbnailImageURL placeholder:(UIImage *)placeholder comopleted:(SDExternalCompletionBlock)completed;


/**
 设置原型头像

 @param headerUrl 头像URLStr
 */
- (void)xy_setHeader:(NSString *)headerUrl;


@end

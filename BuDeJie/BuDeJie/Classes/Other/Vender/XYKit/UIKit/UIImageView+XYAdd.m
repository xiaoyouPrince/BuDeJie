//
//  UIImageView+XYAdd.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/10/17.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "UIImageView+XYAdd.h"

@implementation UIImageView (XYAdd)

- (void)xy_setOriginImage:(NSString *)originImageURL thumbnailImage:(NSString *)thumbnailImageURL placeholder:(UIImage *)placeholder
{
    //    [[SDWebImageManager sharedManager]setCacheKeyFilter:^(NSURL *url) {
    //        // 所有缓存图片的key后面都有个-xmg后缀
    //        return [NSString stringWithFormat:@"%@-xmg", url.absoluteString];
    //    }];
    
    // 根据网络状态来加载图片
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 获得原图（SDWebImage的图片缓存是用图片的url字符串作为key）
    UIImage *originImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:originImageURL];
    if (originImage) { // 原图已经被下载过
        self.image = originImage;
    } else { // 原图并未下载过
        if (mgr.isReachableViaWiFi) {
            [self sd_setImageWithURL:[NSURL URLWithString:originImageURL] placeholderImage:placeholder];
        } else if (mgr.isReachableViaWWAN) {
#warning downloadOriginImageWhen3GOr4G配置项的值需要从沙盒里面获取
            // 3G\4G网络下时候要下载原图
            BOOL downloadOriginImageWhen3GOr4G = YES;
            if (downloadOriginImageWhen3GOr4G) {
                [self sd_setImageWithURL:[NSURL URLWithString:originImageURL] placeholderImage:placeholder];
            } else {
                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageURL] placeholderImage:placeholder];
            }
        } else { // 没有可用网络
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:thumbnailImageURL];
            if (thumbnailImage) { // 缩略图已经被下载过
                self.image = thumbnailImage;
            } else { // 没有下载过任何图片
                // 占位图片;
                self.image = placeholder;
            }
        }
    }
}

- (void)xy_setHeader:(NSString *)headerUrl
{
    UIImage *placeholder = [UIImage circleImageNamed:@"defaultUserIcon"];
    [self sd_setImageWithURL:[NSURL URLWithString:headerUrl] placeholderImage:placeholder options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 图片下载失败，直接返回，按照它的默认做法
        if (!image) return;
        
        self.image = [image circleImage];
    }];
    
    //    [self sd_setImageWithURL:[NSURL URLWithString:headerUrl] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

@end

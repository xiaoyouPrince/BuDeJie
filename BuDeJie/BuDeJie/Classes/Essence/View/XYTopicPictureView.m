//
//  XYTopicPictureView.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/10/13.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "XYTopicPictureView.h"
#import "XYTopic.h"
#import <FLAnimatedImageView.h>


@interface XYTopicPictureView()

@property (weak, nonatomic) IBOutlet FLAnimatedImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *placeholderView;
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;

@end

@implementation XYTopicPictureView


- (void)awakeFromNib
{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setModel:(XYTopic *)model
{
    _model = model;
    
    // 设置图片
    self.placeholderView.hidden = NO;
    
    [self.imageView xy_setOriginImage:model.image1 thumbnailImage:model.image0 placeholder:nil comopleted:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

        if (!image) return;
        
        self.placeholderView.hidden = YES;
        
        // 处理超长图片的大小
        if (model.isBigPicture) {
            CGFloat imageW = model.middleFrame.size.width;
            CGFloat imageH = imageW * model.height / model.width;
            
            // 开启上下文
            UIGraphicsBeginImageContext(CGSizeMake(imageW, imageH));
            // 绘制图片到上下文中
            [self.imageView.image drawInRect:CGRectMake(0, 0, imageW, imageH)];
            self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
            // 关闭上下文
            UIGraphicsEndImageContext();
        }
    }];
    
    // gif
    self.gifView.hidden = !model.is_gif;
    if (model.is_gif) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.image1]];
    }
    
    // 点击查看大图
    if (model.isBigPicture) { // 超长图
        self.seeBigPictureButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeTop;
        self.imageView.clipsToBounds = YES;
    } else {
        self.seeBigPictureButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
        self.imageView.clipsToBounds = NO;
    }
    
}


@end

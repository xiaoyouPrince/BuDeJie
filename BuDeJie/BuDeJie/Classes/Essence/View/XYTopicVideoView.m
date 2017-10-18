//
//  XYTopicVideoView.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/10/13.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "XYTopicVideoView.h"
#import "XYTopic.h"

@interface XYTopicVideoView()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videotimeLabel;

@end

@implementation XYTopicVideoView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // 设置自己AutoResizingMask 为空
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setModel:(XYTopic *)model
{
    _model = model;
    
    // 背景图片
    [self.imageView xy_setOriginImage:model.image1 thumbnailImage:model.image0 placeholder:nil];// 没有默认图片
    
    
    // 播放数量
    if (model.playcount >= 10000) {
        self.playcountLabel.text = [NSString stringWithFormat:@"%.1f万播放", model.playcount / 10000.0];
    } else {
        self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放", model.playcount];
    }
    // %04d : 占据4位，多余的空位用0填补
    self.videotimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", model.voicetime / 60, model.voicetime % 60];
}



@end

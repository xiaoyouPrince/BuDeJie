//
//  XYTopicVoiceView.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/10/13.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "XYTopicVoiceView.h"
#import "XYTopic.h"


@interface XYTopicVoiceView()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voicetimeLabel;

@end

@implementation XYTopicVoiceView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // 自己是xib 来的，创建完毕，直接取消AutoResizingMask防止跟着父控件拉伸
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
    self.voicetimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", model.voicetime / 60, model.voicetime % 60];
}


@end

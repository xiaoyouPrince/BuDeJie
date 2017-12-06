//
//  XYTopicCell.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/10/11.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "XYTopicCell.h"
#import "XYTopic.h"
/**三个内部在子控件*/
#import "XYTopicVideoView.h"
#import "XYTopicVoiceView.h"
#import "XYTopicPictureView.h"

@interface XYTopicCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *text_label;
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIView *topCmtView;
@property (weak, nonatomic) IBOutlet UILabel *topCmtLabel;
/** 图片控件 */
@property (nonatomic, weak) XYTopicPictureView *pictureView;
/** 声音控件 */
@property (nonatomic, weak) XYTopicVoiceView *voiceView;
/** 视频控件 */
@property (nonatomic, weak) XYTopicVideoView *videoView;

@end

@implementation XYTopicCell
static const CGFloat XYMargin = 10;

#pragma mark - 懒加载
- (XYTopicPictureView *)pictureView
{
    if (!_pictureView) {
        XYTopicPictureView *pictureView = [XYTopicPictureView xy_viewFromXib];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (XYTopicVoiceView *)voiceView
{
    if (!_voiceView) {
        XYTopicVoiceView *voiceView = [XYTopicVoiceView xy_viewFromXib];
        [self.contentView addSubview:voiceView];
        _voiceView = voiceView;
    }
    return _voiceView;
}

- (XYTopicVideoView *)videoView
{
    if (!_videoView) {
        XYTopicVideoView *videoView = [XYTopicVideoView xy_viewFromXib];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    return _videoView;
}



- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}


/**
 纯代码初始化cell
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupContent];
    }
    return self;
}


/**
 设置内容
 */
- (void)setupContent
{
    
}


/**
 设置model
 */
- (void)setModel:(XYTopic *)model
{
    _model = model;
    
    // 顶部控件的数据
    // 头像icon(设置圆角图片)
    NSDate *d1 = [NSDate date];
#warning mark --  this place's time cost is 0.002252 - 0.004798
    [self.profileImageView xy_setHeader:model.profile_image];
    NSDate *d2 = [NSDate date];
    double inter = [d2 timeIntervalSinceDate:d1];
    NSLog(@"原型头像时间差 --- %lf",inter);
    
    self.nameLabel.text = model.name;
    self.passtimeLabel.text = model.passtime;
    self.text_label.text = model.text;
    
    // 底部按钮的文字
    [self setupButtonTitle:self.dingButton number:model.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton number:model.cai placeholder:@"踩"];
    [self setupButtonTitle:self.repostButton number:model.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton number:model.comment placeholder:@"评论"];
    
    // 最热评论
    if (model.top_cmt.count) { // 有最热评论
        self.topCmtView.hidden = NO;
        
        NSDictionary *cmt = model.top_cmt.firstObject;
        NSString *content = cmt[@"content"];
        if (content.length == 0) { // 语音评论
            content = @"[语音评论]";
        }
        NSString *username = cmt[@"user"][@"username"];
        self.topCmtLabel.text = [NSString stringWithFormat:@"%@ : %@", username, content];
    } else { // 没有最热评论
        self.topCmtView.hidden = YES;
    }
    
    /** 帖子的类型 10为图片 29为段子 31为音频 41为视频 */
    switch (model.type) {
        case XYTopicTypeWord:
        {
            self.pictureView.hidden = YES;
            self.voiceView.hidden = YES;
            self.videoView.hidden = YES;
        }
            break;
        case XYTopicTypePicture:
        {
            self.pictureView.hidden = NO;
            self.voiceView.hidden = YES;
            self.videoView.hidden = YES;
            
//            self.pictureView.model = model;
            
            
            NSDate *d1 = [NSDate date];
            self.pictureView.model = model;
            NSDate *d2 = [NSDate date];
            double inter = [d2 timeIntervalSinceDate:d1];
            NSLog(@"内部model赋值时间差 --- %lf",inter);
            
        }
            break;
        case XYTopicTypeVoice:
        {
            self.pictureView.hidden = YES;
            self.voiceView.hidden = NO;
            self.videoView.hidden = YES;
            
            // 给内部voice控件赋值
            self.voiceView.model = model;
        }
            break;
        case XYTopicTypeVideo:
        {
            self.pictureView.hidden = YES;
            self.voiceView.hidden = YES;
            self.videoView.hidden = NO;
            
            // 给内部voice控件赋值
            self.videoView.model = model;
        }
            break;
            
        default:
            break;
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.model.type == XYTopicTypePicture) { // 图片
        self.pictureView.frame = self.model.middleFrame;
    } else if (self.model.type == XYTopicTypeVoice) { // 声音
        self.voiceView.frame = self.model.middleFrame;
    } else if (self.model.type == XYTopicTypeVideo) { // 视频
        self.videoView.frame = self.model.middleFrame;
    }
}

/**
 *  设置按钮文字
 *  @param number      按钮的数字
 *  @param placeholder 数字为0时显示的文字
 */
- (void)setupButtonTitle:(UIButton *)button number:(NSInteger)number placeholder:(NSString *)placeholder
{
    if (number >= 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万", number / 10000.0] forState:UIControlStateNormal];
    } else if (number > 0) {
        [button setTitle:[NSString stringWithFormat:@"%zd", number] forState:UIControlStateNormal];
    } else {
        [button setTitle:placeholder forState:UIControlStateNormal];
    }
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= XYMargin;
    
    [super setFrame:frame];
}

@end

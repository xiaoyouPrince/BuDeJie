//
//  XYTopicCell.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/10/11.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "XYTopicCell.h"
#import "XYTopic.h"

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


@end

@implementation XYTopicCell

static const CGFloat XYMargin = 10;


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
    UIImage *placeholder = [UIImage circleImageNamed:@"defaultUserIcon"];
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:model.profile_image] placeholderImage:placeholder options:0 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 图片下载失败，直接返回，按照它的默认做法
        if (!image) return;
        
        self.profileImageView.image = [image circleImage];
    }];
    
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

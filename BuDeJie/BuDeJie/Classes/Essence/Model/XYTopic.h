//
//  XYTopic.h
//  BuDeJie
//
//  Created by 渠晓友 on 2017/10/10.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM( NSInteger , XYTopicType ) {
    /** 全部 */
    XYTopicTypeAll = 1,
    /** 图片 */
    XYTopicTypePicture = 10,
    /** 段子 */
    XYTopicTypeWord = 29,
    /** 声音 */
    XYTopicTypeVoice = 31,
    /** 视频 */
    XYTopicTypeVideo = 41
};

@interface XYTopic : NSObject

/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *passtime;

/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;

/** 帖子的类型 10为图片 29为段子 31为音频 41为视频 */
@property (nonatomic, assign) NSInteger type;

/** 最热评论 */
@property (nonatomic, strong) NSArray *top_cmt;

/** 图片宽度(像素) */
@property (nonatomic, assign) NSInteger width;
/** 图片高度(像素) */
@property (nonatomic, assign) NSInteger height;

#pragma mark -- voice 部分
/** 小图 */
@property (nonatomic, copy) NSString *image0;
/** 中图 */
@property (nonatomic, copy) NSString *image2;
/** 大图 */
@property (nonatomic, copy) NSString *image1;

#pragma mark -- picture 部分
/** 是否为动图 */
@property (nonatomic, assign) BOOL is_gif;
/** 是否为超长图片 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;
#pragma mark -- picture 部分

/** 音频时长 */
@property (nonatomic, assign) NSInteger voicetime;
/** 视频时长 */
@property (nonatomic, assign) NSInteger videotime;
/** 音频\视频的播放次数 */
@property (nonatomic, assign) NSInteger playcount;
#pragma mark -- voice 部分

/** 中间内容的frame */
@property (nonatomic, assign) CGRect middleFrame;


/* 额外增加的属性（并非服务器返回的属性，仅仅是为了提高开发效率） */
/** 根据当前模型计算出来的cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;



@end

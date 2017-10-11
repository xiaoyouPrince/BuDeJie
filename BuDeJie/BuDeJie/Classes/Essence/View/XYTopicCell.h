//
//  XYTopicCell.h
//  BuDeJie
//
//  Created by 渠晓友 on 2017/10/11.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TopicCellID @"TopicCellID"

@class XYTopic;
@interface XYTopicCell : UITableViewCell

@property(nonatomic , strong) XYTopic  *model;


@end

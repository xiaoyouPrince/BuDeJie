//
//  XYSquareCell.h
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/13.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import <UIKit/UIKit.h>

#define XYSquareCellID @"XYSquareCellID"

@class XYSquareItem;
@interface XYSquareCell : UICollectionViewCell

@property(nonatomic , strong) XYSquareItem  *model;


@end

//
//  XYSquareCell.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/13.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "XYSquareCell.h"
#import "XYSquareItem.h"
#import <UIImageView+WebCache.h>

@interface XYSquareCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation XYSquareCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setModel:(XYSquareItem *)model
{
    _model = model;
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageWithColor:XYRandomColor]];
    _nameLabel.text = model.name;
}

@end

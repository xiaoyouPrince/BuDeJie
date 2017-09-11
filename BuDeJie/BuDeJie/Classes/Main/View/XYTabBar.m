//
//  XYTabBar.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/11.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "XYTabBar.h"

@interface XYTabBar ()

@property(nonatomic,weak) UIButton *plusBtn;

@end

@implementation XYTabBar


- (UIButton *)plusBtn
{
    if (_plusBtn == nil) {
        UIButton *plusBtn = [UIButton new];
        [plusBtn setImage:[UIImage imageOriginalWithName:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageOriginalWithName:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [self addSubview:plusBtn];
        [plusBtn addTarget:self action:@selector(plusBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _plusBtn = plusBtn;
    }
    
    return _plusBtn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 重新布局自己的subViews
    NSInteger count = self.items.count + 1; // 多设置一个plusBtn
    CGFloat width = self.bounds.size.width / count;
    CGFloat height = self.bounds.size.height;
    int i = 0;
    
    for (UIView *view in self.subviews) {
        
        DLog(@"%@",view);
        
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                
            if (i == 2) { // 不能写死
                i += 1;
                
                // 添加plusBtn
                self.plusBtn.frame = CGRectMake((i-1)*width, 0, width, height);
            }
            
            view.frame = CGRectMake(i * width, 0, width, height);
            i ++;
        }
    }

    // plusBtn 位置调整
    self.plusBtn.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
    
}

- (void)plusBtnClick:(UIButton *)sender
{
    UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"你好" message:@"此模块正在开发中共" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"好的", nil];
    [a show];
}






@end

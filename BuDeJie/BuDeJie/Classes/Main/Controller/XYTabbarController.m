//
//  XYTabbarController.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/8.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "XYTabbarController.h"
#import "XYEssenceViewController.h"
#import "XYFriendTrendViewController.h"
#import "XYPublishViewController.h"
#import "XYNewViewController.h"
#import "XYProfileViewController.h"
#import "XYKit.h"

@interface XYTabbarController ()

@end

@implementation XYTabbarController

+ (void)load
{
    // 设置item 的 apperence
}

//+ (void)initialize {
//    if (self == [XYTabbarController self]) {
//        // ... do the initialization ...
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置自控制器
    [self setupChildViewControllers];
}


/**
 设置所有子控制器
 */
- (void)setupChildViewControllers
{
    
    XYEssenceViewController *essenceVc = [XYEssenceViewController new];
    [self setupChildViewController:essenceVc title:@"精华"
                         imageName:@"tabBar_essence_icon"
                 selectedImageName:@"tabBar_essence_click_icon"];
    
    XYNewViewController *newVc = [XYNewViewController new];
    [self setupChildViewController:newVc title:@"新帖"
                         imageName:@"tabBar_new_icon"
                 selectedImageName:@"tabBar_new_click_icon"];
    
    XYPublishViewController *publishVc = [XYPublishViewController new];
    [self setupChildViewController:publishVc title:@""
                         imageName:@"tabBar_publish_icon"
                 selectedImageName:@"tabBar_publish_click_icon"];
    
    XYFriendTrendViewController *friendVc = [XYFriendTrendViewController new];
    [self setupChildViewController:friendVc title:@"关注"
                         imageName:@"tabBar_friendTrends_icon"
                 selectedImageName:@"tabBar_friendTrends_click_icon"];
    
    XYProfileViewController *profileVc = [XYProfileViewController new];
    [self setupChildViewController:profileVc title:@"我"
                         imageName:@"tabBar_me_icon"
                 selectedImageName:@"tabBar_me_click_icon"];
}


/**
 设置子控制器

 @param childVc 自控制器
 @param title 标题
 @param imageName 图片名
 @param selectedImageName 选中图片名
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    childVc.title = title;
    
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [UIImage imageOriginalWithName:selectedImageName]; // ios7 之后
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];

    [self addChildViewController:nav];

}


@end

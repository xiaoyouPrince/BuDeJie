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
#import "XYNavigationController.h"
#import "XYTabBar.h"

@interface XYTabbarController ()

@property(nonatomic,weak) XYTabBar *tabbar;

@end

@implementation XYTabbarController

// 设置item 的 apperence
+ (void)load
{
    // 获取哪个类中UITabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    // 设置按钮选中标题的颜色:富文本:描述一个文字颜色,字体,阴影,空心,图文混排
    // 创建一个描述文本属性的字典
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];
    
    // 设置字体尺寸:只有设置正常状态下,才会有效果
    NSMutableDictionary *attrsNor = [NSMutableDictionary dictionary];
    attrsNor[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:attrsNor forState:UIControlStateNormal];
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
    
    // 设置tabbar
    [self setupTabbar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 此方法中tabbar才会添加子控件
//    DLog(@"%@",self.tabBar.subviews);
}


/**
 设置自己的tabbar
 */
- (void)setupTabbar
{
    XYTabBar *tabbar = [XYTabBar new];
    
    // 系统 tabBar 是 readonly 不能直接赋值，但是可以使用 KVC 整体替换 tabBar 属性
    [self setValue:tabbar forKey:@"tabBar"];
    
//    DLog(@"%@",self.tabBar);
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
    
//    XYPublishViewController *publishVc = [XYPublishViewController new];
//    [self setupChildViewController:publishVc title:@""
//                         imageName:@"tabBar_publish_icon"
//                 selectedImageName:@"tabBar_publish_click_icon"];
    
    XYFriendTrendViewController *friendVc = [XYFriendTrendViewController new];
    [self setupChildViewController:friendVc title:@"关注"
                         imageName:@"tabBar_friendTrends_icon"
                 selectedImageName:@"tabBar_friendTrends_click_icon"];
    
    UIStoryboard *profile = [UIStoryboard storyboardWithName:@"XYProfileViewController" bundle:nil];
    XYProfileViewController *profileVc = [profile instantiateInitialViewController];
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
    
    childVc.tabBarItem.image = [UIImage imageOriginalWithName:imageName];
    childVc.tabBarItem.selectedImage = [UIImage imageOriginalWithName:selectedImageName]; // ios7 之后
    
    XYNavigationController *nav = nil;
//    if (![childVc isKindOfClass:[XYPublishViewController class]]) {
        nav = [[XYNavigationController alloc] initWithRootViewController:childVc];
        [self addChildViewController:nav];
//    }else
//    {
//        [self addChildViewController:childVc];
//        childVc.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
//
//    }
}


@end

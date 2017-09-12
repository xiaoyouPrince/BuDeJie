//
//  XYNavigationController.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/12.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "XYNavigationController.h"

@interface XYNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation XYNavigationController

// 设置nav的字体颜色和大小等
+ (void)load
{
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    // title 的大小和颜色
    NSMutableDictionary *attrs = [NSMutableDictionary new];
    attrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    [navBar setTitleTextAttributes:attrs];
    
    // backgroundView
    [navBar setBackIndicatorImage:[UIImage imageNamed:@"navigationButtonReturn"]];
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    DLog(@"%@",self.interactivePopGestureRecognizer);
    DLog(@"%@",self.interactivePopGestureRecognizer.delegate);
 
    /**
     
     系统边缘返回手势
     <UIScreenEdgePanGestureRecognizer: 0x7fdd2be13460; state = Possible; delaysTouchesBegan = YES; view = <UILayoutContainerView 0x7fdd2bf24140>; target= <(action=handleNavigationTransition:, target=<_UINavigationInteractiveTransition 0x7fdd2be13120>)>>
     
     系统边缘返回手势的代理的私有类
     <_UINavigationInteractiveTransition: 0x7fdd2be13120>
    */
    
    
        self.interactivePopGestureRecognizer.enabled = NO;
    
    
    /// 创建一个返回手势添加到self.view上，直接target和action使用系统的target和action
    UIPanGestureRecognizer *edgePan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    edgePan.delegate = self;
    [self.view addGestureRecognizer:edgePan];
    
    self.interactivePopGestureRecognizer.enabled = NO;
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return self.childViewControllers.count > 1; // 有自控制器的时候恢复返回手势
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    DLog(@"%@",self.interactivePopGestureRecognizer);
    DLog(@"%@",self.interactivePopGestureRecognizer.delegate);
    
    if (self.childViewControllers.count > 0) { //非rootViewController
        
        // 设置返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithimage:[UIImage imageNamed:@"navigationButtonReturn"] highImage:[UIImage imageNamed:@"navigationButtonReturnClick"]  target:self action:@selector(back) title:@"返回"];
        viewController.hidesBottomBarWhenPushed = YES;
        
        DLog(@"%@",self.interactivePopGestureRecognizer);
        DLog(@"%@",self.interactivePopGestureRecognizer.delegate);
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back{
    [self popViewControllerAnimated:YES];
}



#warning TODO -- 这里有一个bug就是，添加全屏返回手势之后，如果快速返回就会返回之后NavBar的Item们就会错乱
- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    UIViewController *popVc = [super popViewControllerAnimated:animated];
    
    // 当前topVc 重新来一遍viewDidLoad方法，（里面的NavBar也会重新设置）
//    [self.topViewController viewDidLoad];
    // 这个问题在真机上不会出现，在模拟器上出现，暂时无解。。。
    
    DLog(@"%@",self.topViewController);
    
    return popVc;
}


@end

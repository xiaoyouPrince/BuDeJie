//
//  XYEssenceViewController.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/8.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "XYEssenceViewController.h"
#import "XYTitleButton.h"
#import "XYAllViewController.h"
#import "XYVideoViewController.h"
#import "XYVoiceViewController.h"
#import "XYPictureViewController.h"
#import "XYWordViewController.h"


@interface XYEssenceViewController ()

/** 标题栏 */
@property (nonatomic, weak) UIView *titlesView;
/** 标题下划线 */
@property (nonatomic, weak) UIView *titleUnderline;
/** 上一次点击的标题按钮 */
@property (nonatomic, weak) XYTitleButton *previousClickedTitleButton;

@end

@implementation XYEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self addChildViewControllers];
    
    [self setupNavBar];
    
    [self setupScrollView];
    
    [self setupTitleView];
}

- (void)addChildViewControllers
{
    [self addChildViewController:[XYAllViewController new]];
    [self addChildViewController:[XYVideoViewController new]];
    [self addChildViewController:[XYVoiceViewController new]];
    [self addChildViewController:[XYPictureViewController new]];
    [self addChildViewController:[XYWordViewController new]];

}
- (void)setupNavBar
{
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"nav_item_game_icon"] highImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(game)];
    
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"navigationButtonRandom"] highImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:nil action:nil];
    
    // titleView
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];

}

- (void)game
{
    XYFunc
}


- (void)setupScrollView
{
    // 不允许自动修改UIScrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor blueColor];
    scrollView.frame = self.view.bounds;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    
//        for (NSUInteger i = 0; i < 5; i++) {
//            UITableView *tableView = [[UITableView alloc] init];
//            tableView.xy_width = scrollView.xy_width;
//            tableView.xy_height = scrollView.xy_height;
//            tableView.xy_y = 0;
//            tableView.xy_x = i * scrollView.xy_width;
//            tableView.tag = i;
//            tableView.dataSource = self;
//            tableView.backgroundColor = XYRandomColor;
//            [scrollView addSubview:tableView];
//        }
    
    NSUInteger count = self.childViewControllers.count;
    CGFloat scrollViewW = scrollView.xy_width;
    CGFloat scrollViewH = scrollView.xy_height;

    for (NSUInteger i = 0; i < count; i++) {
        // 取出i位置子控制器的view
        UIView *childVcView = self.childViewControllers[i].view;
        childVcView.frame = CGRectMake(i * scrollViewW, 0, scrollViewW, scrollViewH);
        [scrollView addSubview:childVcView];
    }
    
    scrollView.contentSize = CGSizeMake(count * scrollViewW, 0);
}


- (void)setupTitleView
{
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    titlesView.frame = CGRectMake(0, 64, self.view.xy_width, 35);
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    
    [self setupTitleButtons];
    
    [self setupTitleUnderline];
}

- (void)setupTitleButtons
{
    // 文字
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSUInteger count = titles.count;
    
    // 标题按钮的尺寸
    CGFloat titleButtonW = self.titlesView.xy_width / count;
    CGFloat titleButtonH = self.titlesView.xy_height;
    
    // 创建5个标题按钮
    for (NSUInteger i = 0; i < count; i++) {
        XYTitleButton *titleButton = [[XYTitleButton alloc] init];
        [titleButton addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titlesView addSubview:titleButton];
        // frame
        titleButton.frame = CGRectMake(i * titleButtonW, 0, titleButtonW, titleButtonH);
        // 文字
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
    }
}

- (void)titleButtonClick:(XYTitleButton *)titleButton
{
    // 切换按钮状态
    self.previousClickedTitleButton.selected = NO;
    titleButton.selected = YES;
    self.previousClickedTitleButton = titleButton;
    
    [UIView animateWithDuration:0.25 animations:^{
        // 处理下划线
        self.titleUnderline.xy_width = titleButton.titleLabel.xy_width + 10;
        self.titleUnderline.xy_centerX = titleButton.xy_centerX;
    }];
}

- (void)setupTitleUnderline
{
    // 标题按钮
    XYTitleButton *firstTitleButton = self.titlesView.subviews.firstObject;
    
    // 下划线
    UIView *titleUnderline = [[UIView alloc] init];
    titleUnderline.xy_height = 2;
    titleUnderline.xy_y = self.titlesView.xy_height - titleUnderline.xy_height;
    titleUnderline.backgroundColor = [firstTitleButton titleColorForState:UIControlStateSelected];
    [self.titlesView addSubview:titleUnderline];
    self.titleUnderline = titleUnderline;
    
    // 切换按钮状态
    firstTitleButton.selected = YES;
    self.previousClickedTitleButton = firstTitleButton;
    
    [firstTitleButton.titleLabel sizeToFit]; // 让label根据文字内容计算尺寸
    self.titleUnderline.xy_width = firstTitleButton.titleLabel.xy_width + 10;
    self.titleUnderline.xy_centerX = firstTitleButton.xy_centerX;
}



@end

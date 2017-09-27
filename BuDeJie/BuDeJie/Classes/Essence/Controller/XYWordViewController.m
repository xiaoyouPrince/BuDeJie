//
//  XYWordViewController.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/15.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "XYWordViewController.h"

@interface XYWordViewController ()

@end

@implementation XYWordViewController

static NSString * const cellID = @"CellID";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    XYFunc
    
    self.view.backgroundColor = XYRandomColor;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:XYTabBarButtonDidRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClick) name:XYTitleButtonDidRepeatClickNotification object:nil];
}

- (void)dealloc
{
    [kNotificationCenter removeObserver:self];
}

#pragma mark - 监听

/**
 监听tabbarBtn 重复点击
 */
- (void)tabBarButtonDidRepeatClick
{
    if (self.view.window == nil) return;
    
    if (self.tableView.scrollsToTop == NO) return;
    
    DLog(@" -- %@ -- 刷新数据",self.class);
}
/**
 监听TitleBtn 重复点击
 */
- (void)titleButtonDidRepeatClick
{
    [self tabBarButtonDidRepeatClick];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 19;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"----%ld----%@",indexPath.row,self.class ];
    
    return cell;
}


@end

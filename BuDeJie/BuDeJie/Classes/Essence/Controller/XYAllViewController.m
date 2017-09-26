//
//  XYAllViewController.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/15.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "XYAllViewController.h"

@interface XYAllViewController ()

@property(nonatomic , strong) NSArray  *dataArray;


@end
@implementation XYAllViewController


static NSString * const cellID = @"CellID";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    XYFunc
    
    _dataArray = @[@"ib服务i",@"佛玩法",@"很热很热",@"ljm7",@"脾气九宫格",@"喔i4yjnge",@"欧气会各二个人",@"欧威银行业务 ",@"5uejprklreye5欧尼",@"i34uwtq93848y艾克开会",@"该不该欧委会我IEUHF蓝帆",@"4一公分沃尔夫",@"4\(^o^)/~欧冠"];
    
    self.view.backgroundColor = XYRandomColor;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 25;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"----%ld----%@",indexPath.row,self.class ];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



@end

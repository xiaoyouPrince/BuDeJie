//
//  XYAllViewController.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/15.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "XYAllViewController.h"

@interface XYAllViewController ()

@end
@implementation XYAllViewController


static NSString * const cellID = @"CellID";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = XYRandomColor;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 25;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"----%ld----%@",indexPath.row,self.class ];
    
    return cell;
}



@end

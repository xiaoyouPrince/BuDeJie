//
//  XYSettingsViewController.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/12.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "XYSettingsViewController.h"

@interface XYSettingsViewController ()

@end

static NSString * const cellID = @"cellID";
static NSString * cellText = @"清除缓存";
static NSInteger totalCacheSize = 0;

@implementation XYSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    self.tableView.tableFooterView = [UIView new];
    
    // 计算缓存
    [SVProgressHUD showWithStatus:@"正在计算缓存尺寸...."];
    [XYFileTool getAllFileSizeForDirectoryPath:PATH_OF_CACHE completion:^(NSInteger totalSize) {
        
        totalCacheSize = totalSize;
        
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    }];
}

- (NSString *)cacheSizeStr{
 
    NSInteger totalSize = totalCacheSize;
    NSString *sizeStr = @"清除缓存";
    // MB KB B
    if (totalSize > 1000 * 1000) {
        // MB
        CGFloat sizeF = totalSize / 1000.0 / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fMB)",sizeStr,sizeF];
    } else if (totalSize > 1000) {
        // KB
        CGFloat sizeF = totalSize / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fKB)",sizeStr,sizeF];
    } else if (totalSize > 0) {
        // B
        sizeStr = [NSString stringWithFormat:@"%@(%.ldB)",sizeStr,totalSize];
    }
    
    return sizeStr;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = [self cacheSizeStr];
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"我是第 %ld 个cell",indexPath.row];
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.textLabel.text = [NSString stringWithFormat:@"%@(%ld)",cellText,totalCacheSize];
    
    if (indexPath.row == 0) {
        // 清除缓存
        [XYFileTool removeDirectoryPath:PATH_OF_CACHE];
        totalCacheSize = 0;
        [self.tableView reloadData];
        [SVProgressHUD showSuccessWithStatus:@"已清除"];
    }else
    {
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"正在开发中，请稍后..." delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"好的", nil] show];
    }

}


@end

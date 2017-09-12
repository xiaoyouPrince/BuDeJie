//
//  XYSubTagViewController.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/13.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "XYSubTagViewController.h"
#import "XYSubTagItem.h"
#import "XYSubTagCell.h"

static NSString * const ID = @"subTagCell";

@interface XYSubTagViewController ()

@property(nonatomic , strong) NSArray  *subTags;

@end

@implementation XYSubTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"推荐标签";
    
    [self loadData];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"XYSubTagCell" bundle:nil] forCellReuseIdentifier:ID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = XYColor(220, 220, 221);
}

- (void)loadData
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"tag_recommend";
    parameters[@"action"] = @"sub";
    parameters[@"c"] = @"topic";
    [XYHttpTool getWithURL:@"http://api.budejie.com/api/api_open.php" params:parameters success:^(id json) {
        
        _subTags = [XYSubTagItem mj_objectArrayWithKeyValuesArray:json];
        
        // 刷新表格
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _subTags.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    XYSubTagCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    // 获取模型
    XYSubTagItem *item = self.subTags[indexPath.row];
    cell.model = item;
    return cell;
}



@end

//
//  XYAllViewController.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/15.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "XYAllViewController.h"
#import "MJRefresh.h"
#import "XYTopic.h"

@interface XYAllViewController ()

@property(nonatomic , strong) NSArray  *dataArray;
@property(nonatomic , strong) NSMutableArray  <XYTopic *>*topics;

@end
@implementation XYAllViewController


static NSString * const cellID = @"CellID";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    XYFunc
    
    
    self.topics = [NSMutableArray array];
    
    _dataArray = @[@"ib服务i",@"佛玩法",@"很热很热",@"ljm7",@"脾气九宫格",@"喔i4yjnge",@"欧气会各二个人",@"欧威银行业务 ",@"5uejprklreye5欧尼",@"i34uwtq93848y艾克开会",@"该不该欧委会我IEUHF蓝帆",@"4一公分沃尔夫",@"4\(^o^)/~欧冠"];
    
    self.view.backgroundColor = XYRandomColor;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:XYTabBarButtonDidRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClick) name:XYTitleButtonDidRepeatClickNotification object:nil];
    
    
    // 处理刷新功能
    [self configRefresh];
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


/**
 处理刷新功能
 */
- (void)configRefresh
{
    // 处理header刷新控件，并直接进入刷新状态
    [self dealHeader];
    [self.tableView.mj_header beginRefreshing];
    
    // 处理footer刷新控件
    [self dealFooter];
}

- (void)dealHeader
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

        [self loadNewTopics];
    }];

}

- (void)dealFooter
{
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        DLog(@"dealFooterRefresh");
        
        [self loadMoreTopics];
    }];
}


/**
 下拉刷新新的数据
 */
- (void)loadNewTopics
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @"1"; // 这里发送@1也是可行的
    
    [XYHttpTool getWithURL:XYCommonURL params:parameters success:^(NSDictionary* json) {
        
        DLog(@"%@",json);
        
        
        // 保存数据
        self.topics = [XYTopic mj_objectArrayWithKeyValuesArray:json[@"list"]];
        // tableView刷新数据
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];

        
    } failure:^(NSError *error) {
        
        [self.tableView.mj_header endRefreshing];

        
    }];
}

/**
 上拉加载更多数据
 */
- (void)loadMoreTopics
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @"1"; // 这里发送@1也是可行的
    
    [XYHttpTool getWithURL:XYCommonURL params:parameters success:^(id json) {
        
        // 保存数据
        NSMutableArray *arrayM = [XYTopic mj_objectArrayWithKeyValuesArray:json[@"list"]];
        [self.topics addObjectsFromArray:arrayM];
        // tableView刷新数据
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
    }];
    
    
    
    [self.tableView.mj_footer endRefreshing];
}



#pragma mark -- UITableViewDelegate && UITableviewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"----%ld----%@",indexPath.row,self.topics[indexPath.row].name];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    DLog(@"%@",NSStringFromUIOffset(UIOffsetMake(scrollView.contentOffset.x, scrollView.contentOffset.y)));
//}



@end

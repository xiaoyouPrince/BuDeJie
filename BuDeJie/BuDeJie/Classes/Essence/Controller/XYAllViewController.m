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
#import "XYTopicCell.h"


@interface XYAllViewController ()

@property(nonatomic , strong) NSArray  *dataArray;

/** 数据数组 */
@property(nonatomic , strong) NSMutableArray  <XYTopic *>*topics;
/** 记录上次刷新最大值 */
@property(nonatomic , strong) NSString  *maxtime; // 同maxid

@end
@implementation XYAllViewController

//static NSString * const cellID = @"CellID";
//static NSString * const TopicCellID = @"TopicCellID";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    XYFunc
    
    
    self.topics = [NSMutableArray array];
    
    _dataArray = @[@"ib服务i",@"佛玩法",@"很热很热",@"ljm7",@"脾气九宫格",@"喔i4yjnge",@"欧气会各二个人",@"欧威银行业务 ",@"5uejprklreye5欧尼",@"i34uwtq93848y艾克开会",@"该不该欧委会我IEUHF蓝帆",@"4一公分沃尔夫",@"4\(^o^)/~欧冠"];
    
    if (iOS11) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }

    
    self.view.backgroundColor = kGlobalBg;
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TopicCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"XYTopicCell" bundle:nil] forCellReuseIdentifier:TopicCellID];
    
    
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

// scrollView 滚动完毕之后清理内存缓存
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [[SDImageCache sharedImageCache] clearMemory];
}


/**
 返回下载类型
 */
- (XYTopicType)loadType
{
    return XYTopicTypePicture;
}


/**
 下拉刷新新的数据
 */
- (void)loadNewTopics
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"c"] = @"data";
    parameters[@"type"] = @(self.loadType); // 这里发送@1也是可行的
    
    [XYHttpTool getWithURL:XYCommonURL params:parameters success:^(NSDictionary* json) {
        
        DLog(@"%@",json);
        
        // 保存刷新的到数据的最大值
        self.maxtime = json[@"info"][@"maxtime"];
        
        // 保存数据
        self.topics = [XYTopic mj_objectArrayWithKeyValuesArray:json[@"list"]];
        // tableView刷新数据
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];

        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后重试..."];
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
    parameters[@"type"] = @(self.loadType); // 这里发送@1也是可行的
    parameters[@"maxtime"] = self.maxtime;
    
    [XYHttpTool getWithURL:XYCommonURL params:parameters success:^(id json) {
        
        // 保存刷新的到数据的最大值
        self.maxtime = json[@"info"][@"maxtime"];
        
        // 保存数据
        NSMutableArray *arrayM = [XYTopic mj_objectArrayWithKeyValuesArray:json[@"list"]];
        [self.topics addObjectsFromArray:arrayM];
        // tableView刷新数据
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络繁忙，请稍后重试..."];
        [self.tableView.mj_footer endRefreshing];
    }];

    [self.tableView.mj_footer endRefreshing];
}



#pragma mark -- UITableViewDelegate && UITableviewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}

/**
 估算高度：
 有估算高度，数据源调用顺序 --> 先 cellForRow 然后调用对应 heightForRow
 没有估算高度，数据源调用顺序 --> 先 heightForRow 然后调用对应 cellForRow
 */
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"heightForRowAtIndexPath---------");
    return self.topics[indexPath.row].cellHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"cellForRowAtIndexPath---------");
    XYTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:TopicCellID];
    
    // Marrk : 在iOS 11 中无论是用不用估算高度方法，这里都是先执行cellForRow方法，所以计算高度和大图直接在这里进行，防止iOS 11之下，运行的过程中 model.isBigPicture 为赋值
    XYTopic *model = self.topics[indexPath.row];
    [model calculateIsBigPicture];
    cell.model = model;
    return cell;
}






@end

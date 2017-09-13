//
//  XYProfileViewController.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/8.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "XYProfileViewController.h"
#import "XYSettingsViewController.h"
#import "XYSquareItem.h"
#import "XYSquareCell.h"

static NSInteger const clos = 4;
static CGFloat const margin = 1;
#define cellWH (ScreenW - (clos - 1) * margin ) / clos


@interface XYProfileViewController ()<UICollectionViewDataSource>

@property(nonatomic,weak) UICollectionView *collectionView;

/// 数据
@property (nonatomic, strong) NSMutableArray *squareItems;

@end

@implementation XYProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航条
    [self setupNavBar];
    
    // 设置footerView
    [self setupTableFooterView];
    
    // 请求数据
    [self loadData];
}

- (void)setupNavBar
{
    // 左边按钮
    
    // 设置
    UIBarButtonItem *settingItem =  [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"mine-setting-icon"] highImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(setting)];
    
    // 夜间模型
    UIBarButtonItem *nightItem =  [UIBarButtonItem itemWithimage:[UIImage imageNamed:@"mine-moon-icon"] selImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(night:)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,nightItem];
    
    // titleView
    self.navigationItem.title = @"我的";
    
}

- (void)night:(UIButton *)button
{
    button.selected = !button.selected;
    
}

- (void)setting
{
    /// 进入对应的列表页面
    XYSettingsViewController *settingVc = [XYSettingsViewController new];
    [self.navigationController pushViewController:settingVc animated:YES];

}

- (void)setupTableFooterView
{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize = CGSizeMake(cellWH, cellWH);
    layout.minimumLineSpacing = margin;
    layout.minimumInteritemSpacing = margin;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 300) collectionViewLayout:layout];
    [collectionView registerNib:[UINib nibWithNibName:@"XYSquareCell" bundle:nil] forCellWithReuseIdentifier:XYSquareCellID];
    collectionView.dataSource = self;
    collectionView.collectionViewLayout = layout;
    collectionView.backgroundColor = self.tableView.backgroundColor;
    collectionView.scrollEnabled = NO;
    _collectionView = collectionView;
    
    self.tableView.tableFooterView = collectionView;
}

- (void)loadData
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"square";
    parameters[@"c"] = @"topic";
    
    [XYHttpTool getWithURL:@"http://api.budejie.com/api/api_open.php" params:parameters success:^(id json) {
        
        NSArray *list = json[@"square_list"];
        
        _squareItems = [XYSquareItem mj_objectArrayWithKeyValuesArray:list];
        
        [self resolveData];
        
        // 重新设置CollectionView的高度
        NSInteger count = self.squareItems.count;
        CGFloat rows = (count - 1) / clos + 1;
        self.collectionView.xy_height = rows * cellWH;
        
        self.tableView.tableFooterView = self.collectionView;
        
        
        [_collectionView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)resolveData
{
    //
}


#pragma mark -- UICollectionView Data Source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _squareItems.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XYSquareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XYSquareCellID forIndexPath:indexPath];
    
    cell.model = _squareItems[indexPath.row];
    
    return cell;
}



@end

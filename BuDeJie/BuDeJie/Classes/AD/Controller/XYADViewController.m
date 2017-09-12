//
//  XYADViewController.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/12.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "XYADViewController.h"
#import "XYADItem.h"

@interface XYADViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (weak, nonatomic) IBOutlet UIView *adContainerView;
@property (weak, nonatomic) IBOutlet UIButton *countBtn;
@property(nonatomic,weak) UIImageView *adView; ///< 广告页
@property(nonatomic , strong) XYADItem *item;


@end


#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

@implementation XYADViewController

- (UIImageView *)adView
{
    if (_adView == nil) {
        
        UIImageView *adView = [UIImageView new];
        [self.adContainerView addSubview:adView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [adView addGestureRecognizer:tap];
        adView.userInteractionEnabled = YES;
        _adView = adView;
    }
    return _adView;
}

// adView的点击
- (void)tap
{
    // 跳转到界面 => safari
    NSURL *url = [NSURL URLWithString:_item.ori_curl];
    UIApplication *app = [UIApplication sharedApplication];
    if ([app canOpenURL:url]) {
        [app openURL:url];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置启动图片
    [self setupLaunchImage];
    
    // 加载数据
    [self loadData];
}

/**
 设置启动图片
 */
- (void)setupLaunchImage
{
    // 6p:LaunchImage-800-Portrait-736h@3x.png
    // 6:LaunchImage-800-667h@2x.png
    // 5:LaunchImage-568h@2x.png
    // 4s:LaunchImage@2x.png
    if (iPhone6P) { // 6p
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    } else if (iPhone6) { // 6
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    } else if (iPhone5) { // 5
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-568h"];
    } else if (iPhone4) { // 4
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-700"];
    }
    
    
//    self.countBtn.layer.cornerRadius
}

- (void)loadData
{
    NSMutableDictionary *params = [NSMutableDictionary new];
    params[@"code2"] = code2;
    [XYHttpTool getWithURL:@"http://mobads.baidu.com/cpro/ui/mads.php" params:params success:^(NSDictionary * json) {
        
        NSArray *adArray = json[@"ad"];
        if (adArray.count) {

            // 有数据直接用网络数据
            _item = [XYADItem mj_objectWithKeyValues:adArray.lastObject];
            [self showAdView];

        }else{
            // 没有数据，使用plist默认的
            NSDictionary *dict = @{@"w_picurl" : @"http://ubmcmm.baidustatic.com/media/v1/0f000ckXT-0f0AHIgku-N6.jpg",
                                   @"ori_curl" : @"http://union.dbba.cn:8080/pv?uid=7&cid=55",
                                   @"w" : @"768",
                                   @"h" : @"1024"};
            _item = [XYADItem mj_objectWithKeyValues:dict];
            [self showAdView];
        }
        
    } failure:^(NSError *error) {
        DLog(@"%@",error);
    }];
    
}

- (void)showAdView
{
    CGFloat adViewH = ScreenW / _item.w * _item.h;
    self.adView.frame = CGRectMake(0, 0, ScreenW, adViewH);
    if (_item.w_picurl.length) {
        [self.adView sd_setImageWithURL:[NSURL URLWithString:_item.w_picurl]];
    }
}





@end

//
//  XYSeeBigPictureViewController.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/12/6.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "XYSeeBigPictureViewController.h"
#import "XYTopic.h"

@interface XYSeeBigPictureViewController ()<UIScrollViewDelegate>

@property(nonatomic , strong) UIScrollView  *scrollView;
@property(nonatomic , strong) UIButton  *backBtn;
@property(nonatomic , strong) UIButton  *saveBtn;
@property(nonatomic,weak) UIImageView *imageView;

@end

@implementation XYSeeBigPictureViewController

#pragma mark -- lazy load

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [UIScrollView new];
        _scrollView.frame = self.view.bounds;
        _scrollView.backgroundColor = [UIColor lightGrayColor];
        
        //Delegate
        _scrollView.delegate = self;
        _scrollView.minimumZoomScale = 1.0;
        _scrollView.maximumZoomScale = 2.0f;
    }
    return _scrollView;
}

- (UIButton *)backBtn
{
    if (_backBtn == nil) {
        _backBtn = [UIButton new];
        
        [_backBtn setImage:[UIImage imageNamed:@"show_image_back_icon"] forState:UIControlStateNormal];
        [_backBtn setBackgroundColor: [UIColor clearColor]];
        [_backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [_backBtn sizeToFit];
        
        CGFloat btnW = _backBtn.xy_width;
        CGFloat btnH = _backBtn.xy_height;
        _backBtn.frame = CGRectMake(15 , 40, btnW ,btnH);
        
    }
    return _backBtn;
}

- (UIButton *)saveBtn
{
    if (_saveBtn == nil) {
        _saveBtn = [UIButton new];
        _saveBtn.enabled = NO;
        
        [_saveBtn setTitle:@"save" forState:UIControlStateNormal];
        [_saveBtn setBackgroundColor: [UIColor colorWithWhite:0.5 alpha:0.5]];
        [_saveBtn addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat btnW = 100;
        CGFloat btnH = 50;
        _saveBtn.frame = CGRectMake(ScreenW - 20 - btnW, ScreenH - 50 - btnH, btnW, btnH);
    }
    return _saveBtn;
}

#pragma mark -- life circle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.saveBtn];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [self.scrollView addSubview: imageView];
    _imageView = imageView;


    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.image1] placeholderImage:[UIImage imageNamed:@"imageBackground"] options:1 << 12 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
        // 正在下载中
        float progress = (receivedSize / expectedSize);
        do {
            [SVProgressHUD showProgress:progress];
        } while (progress == 1);
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        if (!image) {
            return ;
        }
        self.saveBtn.enabled = YES;
    }];
    
    CGFloat imageW = self.scrollView.xy_width;
    CGFloat imageH = imageW * self.model.height / self.model.width;
    if (imageH > ScreenH) {
        
#warning mark -- status bar 20 px height
        imageView.frame = CGRectMake(0, -20, imageW, imageH); // why 高度默认是 20 开始的呢？
        self.scrollView.contentSize = CGSizeMake(0, imageH - 20);
    }else
    {
        imageView.frame = CGRectMake(0, 0, imageW, imageH);
        imageView.center = self.scrollView.center;
    }
}

- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveImage{

    NSLog(@"saveImage");

}

#pragma mark scrollView Delegate

//- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
//{
//
//}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

//- (void)scrollViewDidZoom:(UIScrollView *)scrollView
//{
//    NSLog(@"scrollViewDidZoom");
//}


@end

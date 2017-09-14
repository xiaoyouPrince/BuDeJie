//
//  XYWebViewController.m
//  BuDeJie
//
//  Created by 渠晓友 on 2017/9/14.
//  Copyright © 2017年 XiaoYou. All rights reserved.
//

#import "XYWebViewController.h"
#import <WebKit/WebKit.h>


@interface XYWebViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshItem;
@property (weak, nonatomic) WKWebView *webView;


@end

@implementation XYWebViewController

- (IBAction)backItemClick:(id)sender {
   
    [self.webView goBack];
    
}
- (IBAction)nextItemClick:(id)sender {
    
    [self.webView goForward];
}

- (IBAction)refreshItemClick:(id)sender {
    
    [self.webView reload];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加webView
    WKWebView *webView = [[WKWebView alloc] init];
    webView.frame = self.containerView.bounds;
    [self.containerView addSubview:webView];
    _webView = webView;
    
    // 展示网页
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [webView loadRequest:request];
    
    [self observeWebView];
}

- (void)observeWebView
{
    // KVO监听属性改变
    /*
     Observer:观察者
     KeyPath:观察webView哪个属性
     options:NSKeyValueObservingOptionNew:观察新值改变
     
     KVO注意点.一定要记得移除
     */
    [_webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [_webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
    // 进度条
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
}

// 只要观察对象属性有新值就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    self.backItem.enabled = self.webView.canGoBack;
    self.nextItem.enabled = self.webView.canGoForward;
    self.title = self.webView.title;
    self.progressView.progress = self.webView.estimatedProgress;
    self.progressView.hidden = self.webView.estimatedProgress >= 1;
}

#pragma mark - 对象被销毁
- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView removeObserver:self forKeyPath:@"canGoForward"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}


@end

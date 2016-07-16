//
//  ViewController.m
//  WechatWebViewProgressDemo
//
//  Created by lz on 16/7/15.
//  Copyright © 2016年 lz. All rights reserved.
//

#import "ViewController.h"
#import "LZProgresSHeader.h"

@interface ViewController ()<UIWebViewDelegate,LZWebViewProgressDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)refreshWebView:(id)sender;

@end

@implementation ViewController
{
    LZWebViewProgressView *_progressView;
    LZWebViewProgress *_progressProxy;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    self.automaticallyAdjustsScrollViewInsets = NO;

    _progressProxy = [[LZWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[LZWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.bilibili.com"]];
    [self.webView loadRequest:req];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_progressView removeFromSuperview];
}

- (IBAction)refreshWebView:(id)sender {
    [self.webView reload];
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(LZWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress];
}


@end

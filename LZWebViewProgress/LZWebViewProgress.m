//
//  LZWebViewProgress.m
//  WechatWebViewProgressDemo
//
//  Created by lz on 16/7/15.
//  Copyright © 2016年 lz. All rights reserved.
//

#import "LZWebViewProgress.h"

const float LZInitialProgressValue = 0.1;
const float LZFinalProgressValue = 0.92;

@interface LZWebViewProgress ()<UIWebViewDelegate>
@property (nonatomic, readonly) float progress; // 0.0..1.0

@end

@implementation LZWebViewProgress
{
    float progressCount; //0...1000
    dispatch_source_t _timer;
}


- (id)init
{
    self = [super init];
    if (self) {
        progressCount = 0;
    }
    return self;
}

- (void)startProgress
{
    if (_progress <= LZInitialProgressValue) {
        progressCount = LZInitialProgressValue * 1000;
        [self setProgress:LZInitialProgressValue];
        
    }
    [self incrementProgress];
}

- (void)completeProgress
{
    [self setProgress:1.0];
    if(_timer)
    {
        dispatch_source_cancel(_timer);
    }
}

- (void)reset
{
    [self setProgress:0.0];
    if(_timer)
    {
        dispatch_source_cancel(_timer);
    }
}

- (void)incrementProgress
{
    NSTimeInterval period = 100.0; //设置时间间隔
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
     _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), period * NSEC_PER_MSEC, 0);
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if (progressCount >= 0 && progressCount < 500) {
            progressCount += 50;
        }else
        {
            if (progressCount >= 500 && progressCount < 700) {
                progressCount += 20;
            }else
            {
                if (progressCount >= 700 && progressCount < 850) {
                    progressCount += 15;
                }else
                {
                    if (progressCount >= 850 && progressCount <= LZFinalProgressValue * 1000) {
                        progressCount += 1;
                    }else{
                        
                        if(_timer)
                        {
                            dispatch_source_cancel(_timer);
                        }
                    }
                }
            }
        }
        
        float progress = progressCount / 1000;
        [self setProgress:progress];
        
    });
    
    dispatch_resume(_timer);
}

- (void)setProgress:(float)progress
{
    if (progress > _progress || progress == 0) {
        _progress = progress;
        if ([_progressDelegate respondsToSelector:@selector(webViewProgress:updateProgress:)]) {
            [_progressDelegate webViewProgress:self updateProgress:progress];
        }
    }
}

#pragma mark -
#pragma mark UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    BOOL ret = YES;
    
    if ([_webViewProxyDelegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)]) {
        ret = [_webViewProxyDelegate webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    
    return ret;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if ([_webViewProxyDelegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [_webViewProxyDelegate webViewDidStartLoad:webView];
    }
    [self reset];
    [self startProgress];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if ([_webViewProxyDelegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [_webViewProxyDelegate webViewDidFinishLoad:webView];
    }
    
    [self completeProgress];
    
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    if ([_webViewProxyDelegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [_webViewProxyDelegate webView:webView didFailLoadWithError:error];
    }
    [self reset];
}





@end

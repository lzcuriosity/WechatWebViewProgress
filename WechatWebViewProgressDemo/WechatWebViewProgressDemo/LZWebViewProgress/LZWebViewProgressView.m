//
//  LZWebViewProgressView.m
//  WechatWebViewProgressDemo
//
//  Created by lz on 16/7/15.
//  Copyright © 2016年 lz. All rights reserved.
//

#import "LZWebViewProgressView.h"

@interface LZWebViewProgressView()

@property (nonatomic,assign) float progress;
@property (nonatomic,strong) UIView*  progressBarView;

@property (nonatomic,assign) NSTimeInterval barAnimationDuration; // default 0.1
@property (nonatomic,assign) NSTimeInterval fadeAnimationDuration; // default 0.27
@property (nonatomic,assign) NSTimeInterval fadeOutDelay; // default 0.1


@end

@implementation LZWebViewProgressView

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureViews];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self configureViews];
}

-(void)configureViews
{
    self.userInteractionEnabled = NO;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _progressBarView = [[UIView alloc] initWithFrame:self.bounds];
    _progressBarView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    UIColor *tintColor = [UIColor colorWithRed:22.f / 255.f green:126.f / 255.f blue:251.f / 255.f alpha:1.0]; // iOS7 Safari bar color
    if ([UIApplication.sharedApplication.delegate.window respondsToSelector:@selector(setTintColor:)] && UIApplication.sharedApplication.delegate.window.tintColor) {
        tintColor = UIApplication.sharedApplication.delegate.window.tintColor;
    }
    _progressBarView.backgroundColor = tintColor;
    [self addSubview:_progressBarView];
    
    _barAnimationDuration = 0.27f;
    _fadeAnimationDuration = 0.27f;
    _fadeOutDelay = 0.1f;
}

-(void)setProgressColor:(UIColor *)color
{
    if (color) {
        _progressBarView.backgroundColor = color;
    }
}

- (void)setProgress:(float)progress
{
    BOOL isGrowing = progress > 0.0 && progress < 1.0;
    if (isGrowing) {
        [UIView animateWithDuration:_barAnimationDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CGRect frame = _progressBarView.frame;
            frame.size.width = progress * self.bounds.size.width;
            _progressBarView.frame = frame;
            _progressBarView.alpha = 1.0;
        } completion:nil];
    }
    
    BOOL isFinished = progress >= 1.0;
    if (isFinished) {
        [UIView animateWithDuration:_fadeAnimationDuration delay:_fadeOutDelay options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _progressBarView.alpha = 0.0;
        } completion:^(BOOL completed){
            CGRect frame = _progressBarView.frame;
            frame.size.width = 0;
            _progressBarView.frame = frame;
        }];
    }
    
}

@end

//
//  LZWebViewProgress.h
//  WechatWebViewProgressDemo
//
//  Created by lz on 16/7/15.
//  Copyright © 2016年 lz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern const float LZInitialProgressValue;
extern const float LZInteractiveProgressValue;
extern const float LZFinalProgressValue;

typedef void (^LZWebViewProgressBlock)(float progress);

@protocol LZWebViewProgressDelegate;

@interface LZWebViewProgress : NSObject

@property (nonatomic, weak) id<LZWebViewProgressDelegate>progressDelegate;
@property (nonatomic, weak) id<UIWebViewDelegate>webViewProxyDelegate;

- (void)reset;

@end

@protocol LZWebViewProgressDelegate <NSObject>
- (void)webViewProgress:(LZWebViewProgress *)webViewProgress updateProgress:(float)progress;
@end

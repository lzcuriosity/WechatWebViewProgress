# WechatWebViewProgress

这是一个仿照微信的WebViewProgress，与github上多星的 [**NJKWebViewProgress**](https://github.com/ninjinkun/NJKWebViewProgress) 有所区别，有兴趣可以看看。

## 效果图

### 网络正常

![](http://zen3-blog.oss-cn-shenzhen.aliyuncs.com/WebViewProgress/%20lz%E6%AD%A3%E5%B8%B8.gif)

---

### 网络不正常

![](http://zen3-blog.oss-cn-shenzhen.aliyuncs.com/WebViewProgress/lz%E4%B8%8D%E6%AD%A3%E5%B8%B8.gif)

## 使用

### 导入头文件

```objc
#import "LZProgresSHeader.h"
```

###  需要对象

```objc
LZWebViewProgressView *_progressView;
LZWebViewProgress *_progressProxy;
```

### 具体代码

```objc
#import "ViewController.h"
#import "LZProgresSHeader.h"

@interface ViewController ()<UIWebViewDelegate,LZWebViewProgressDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

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

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(LZWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress];
}

@end
```
具体可查看我的 demo 实现。

这里面的 **LZWebViewProgress** 文件是需要导入的SDK; **WechatWebViewProgressDemo** 是上面我写的使用演示demo。

## 详情

具体实现思路可以看看我的博客：http://lzcuriosity.github.io/2016/07/16/源码分享：仿微信的WebViewProgress/

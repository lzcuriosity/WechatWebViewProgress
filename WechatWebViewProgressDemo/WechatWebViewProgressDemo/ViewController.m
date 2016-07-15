//
//  ViewController.m
//  WechatWebViewProgressDemo
//
//  Created by lz on 16/7/15.
//  Copyright © 2016年 lz. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)refreshWebView:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.webView.delegate = self;
    NSURLRequest *req = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://lzcuriosity.github.io"]];
    [self.webView loadRequest:req];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (IBAction)refreshWebView:(id)sender {
    [self.webView reload];
}


@end

//
//  OpenPageViewController.m
//  test
//
//  Created by lv zaiyi on 2017/7/21.
//  Copyright © 2017年 lv zaiyi. All rights reserved.
//

#import "OpenPageViewController.h"
#import <WebKit/WebKit.h>

@interface OpenPageViewController ()<WKNavigationDelegate,WKUIDelegate>
@property (nonatomic,strong) WKWebView *webView;
@end

@implementation OpenPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat navBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGRect webRect = self.view.bounds;
    webRect.size.height -= (statusBarHeight+navBarHeight);
    self.webView = [[WKWebView alloc] initWithFrame:webRect];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    [self.webView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.webView];
    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    if (!_host) {
        decisionHandler(WKNavigationResponsePolicyAllow);
        return;
    }
    if ([navigationResponse.response.URL.absoluteString containsString:_host]) {
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)3.0 * NSEC_PER_SEC);
//        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//        dispatch_async(queue, ^{
//           
//        });
        __weak __typeof(self) weakSelf = self;
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf back];
        });
        //不允许跳转
//        decisionHandler(WKNavigationResponsePolicyCancel);
    }
//    else{
        decisionHandler(WKNavigationResponsePolicyAllow);
//    }
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)setNav{
    self.title = _pageTitle;
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationItem setLeftBarButtonItem:[self customBarBtnItemWithImageName:@"back" action:@selector(navBack) frame:CGRectMake(0, 0, 11, 22)]];
    // [self.navigationItem setRightBarButtonItem:[self customBarBtnItemWithImageName:@"news" action:@selector(dismissVC) frame:CGRectMake(0, 0, 25, 25)]];
}

- (UIBarButtonItem *)customBarBtnItemWithImageName:(NSString *)imageName action:(SEL)action frame:(CGRect)rect{
    UIImage* image= [UIImage imageNamed:imageName];

    UIButton *someButton= [[UIButton alloc] initWithFrame:rect];
    [someButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [someButton setBackgroundImage:image forState:UIControlStateNormal];
    // [someButton setShowsTouchWhenHighlighted:YES];
    UIBarButtonItem* leftBarItem= [[UIBarButtonItem alloc] initWithCustomView:someButton];
    return leftBarItem;
}

#pragma mark - WKUIDelegate

- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    WKFrameInfo *frameInfo = navigationAction.targetFrame;
    if (![frameInfo isMainFrame]) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}


- (void)back{
    if ([self.delegate respondsToSelector:@selector(popCallback:)]) {
        [self.delegate popCallback:nil];
    }
}

- (void)dismissVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)navBack {
    if (self.webView.canGoBack) {
        [self.webView goBack];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

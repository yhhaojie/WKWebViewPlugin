//
//  OpenPageViewController.m
//  test
//
//  Created by lv zaiyi on 2017/7/21.
//  Copyright © 2017年 lv zaiyi. All rights reserved.
//

#import "OpenPageViewController.h"
#import <WebKit/WebKit.h>

@interface OpenPageViewController ()

@end

@implementation OpenPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNav];
    
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    [webView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:webView];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)setNav{
    self.title = _pageTitle;
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    [self.navigationItem setLeftBarButtonItem:[self customBarBtnItemWithImageName:@"back" action:@selector(dismissVC) frame:CGRectMake(0, 0, 15, 25)]];
    
//    [self.navigationItem setRightBarButtonItem:[self customBarBtnItemWithImageName:@"news" action:@selector(dismissVC) frame:CGRectMake(0, 0, 25, 25)]];
}

- (UIBarButtonItem *)customBarBtnItemWithImageName:(NSString *)imageName action:(SEL)action frame:(CGRect)rect{
    UIImage* image= [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:@"png"]];
    UIButton *someButton= [[UIButton alloc] initWithFrame:rect];
    [someButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [someButton setBackgroundImage:image forState:UIControlStateNormal];
//    [someButton setShowsTouchWhenHighlighted:YES];
    UIBarButtonItem* leftBarItem= [[UIBarButtonItem alloc] initWithCustomView:someButton];
    return leftBarItem;
}

- (void)dismissVC{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

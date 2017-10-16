//
//  YHContact.m
//  cutePuppyPics
//
//  Created by lv zaiyi on 2017/5/23.
//
//

#import "WKWebViewPlugin.h"
#import "OpenPageViewController.h"
#import "YHWebViewController.h"

@interface WKWebViewPlugin()<OpenPageViewControllerDelegate>

@property (nonatomic, copy) NSString *callbackId;
@property (nonatomic, strong) NSMutableArray *array;
@property (strong, nonatomic)OpenPageViewController *opvc;

@end


@implementation WKWebViewPlugin

- (void)openPage:(CDVInvokedUrlCommand *)command {
    NSDictionary *dict  = [command argumentAtIndex:0 withDefault:nil];
    if (dict) {
        NSAssert(dict[@"URL"], @"WKWebViewPlugin's url can not be empty");
        self.callbackId = [command.callbackId copy];
        self.array = [NSMutableArray array];
        
        _opvc = [[OpenPageViewController alloc] init];
        _opvc.delegate = self;
        _opvc.url = dict[@"URL"];
        _opvc.pageTitle = dict[@"title"];
        _opvc.host = dict[@"host"];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_opvc];
        
        [self.viewController presentViewController:nav animated:YES completion:nil];
    }
}

- (void)popCallback:(NSDictionary *)dict{
    [self sendResult:dict];
    [_opvc dismissVC];
}

- (void)sendResult:(NSDictionary*) resultDict{
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:resultDict];
    [self.commandDelegate sendPluginResult:result callbackId:_callbackId];
}

#pragma mark - 

- (void)openYhWebView:(CDVInvokedUrlCommand *)command {
    NSDictionary *dict  = [command argumentAtIndex:0 withDefault:nil];
    if (dict) {
        NSAssert(dict[@"URL"], @"WKWebViewPlugin's url can not be empty");

        NSString *url = dict[@"URL"];
        NSString *pageTitle = dict[@"title"];
        NSString *runJsCode = dict[@"funcAddParam"];
        
        YHWebViewController *webViewC = [[YHWebViewController alloc] initWithTitle:pageTitle urlStr:url runJsCode:runJsCode];
        UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:webViewC];
        navC.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil];
        navC.navigationBar.barTintColor = [UIColor blackColor];
        navC.navigationBar.translucent = NO;
        navC.navigationBar.barStyle = UIStatusBarStyleLightContent;

        [self.viewController presentViewController:navC animated:YES completion:^{}];
    }
    
}

@end

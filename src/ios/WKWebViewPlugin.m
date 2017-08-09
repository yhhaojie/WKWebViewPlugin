//
//  YHContact.m
//  cutePuppyPics
//
//  Created by lv zaiyi on 2017/5/23.
//
//

#import "WKWebViewPlugin.h"
#import "OpenPageViewController.h"

@interface WKWebViewPlugin()

@property (nonatomic, copy) NSString *callbackId;
@property (nonatomic, strong) NSMutableArray *array;

@end


@implementation WKWebViewPlugin

- (void)openPage:(CDVInvokedUrlCommand *)command{
    NSDictionary *dict  = [command argumentAtIndex:0 withDefault:nil];
    if (dict) {
        NSAssert(dict[@"URL"], @"WKWebViewPlugin's url can not be empty");
        _callbackId = [command.callbackId copy];
        self.array = [NSMutableArray array];
        
        OpenPageViewController *openPageVC = [[OpenPageViewController alloc] init];
        openPageVC.url = dict[@"URL"];
        openPageVC.title = dict[@"title"];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:openPageVC];
        
        [self.viewController presentViewController:nav animated:YES completion:nil];
    }
}
@end

//
//  YHContact.m
//  cutePuppyPics
//
//  Created by lv zaiyi on 2017/5/23.
//
//

#import "WKWebViewPlugin.h"
#import "OpenPageViewController.h"

@interface WKWebViewPlugin()<OpenPageViewControllerDelegate>

@property (nonatomic, copy) NSString *callbackId;
@property (nonatomic, strong) NSMutableArray *array;
@property (strong, nonatomic)OpenPageViewController *opvc;
@end


@implementation WKWebViewPlugin

- (void)openPage:(CDVInvokedUrlCommand *)command{
    NSDictionary *dict  = [command argumentAtIndex:0 withDefault:nil];
    if (dict) {
        NSAssert(dict[@"URL"], @"WKWebViewPlugin's url can not be empty");
        self.callbackId = [command.callbackId copy];
        self.array = [NSMutableArray array];
        
        _opvc = [[OpenPageViewController alloc] init];
        _opvc.url = dict[@"URL"];
        _opvc.title = dict[@"title"];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_opvc];
        
        [self.viewController presentViewController:nav animated:YES completion:nil];
    }
}

- (void)popCallback:(NSDictionary *)dict{
    [self sendResult:dict];
    [_opvc dismissVC];
}

-(void)sendResult:(NSDictionary*) resultDict{
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:nil];
    [self.commandDelegate sendPluginResult:result callbackId:_callbackId];
}
@end

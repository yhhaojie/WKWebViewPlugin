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
        //dict[@"url"]
        _callbackId = [command.callbackId copy];
        self.array = [NSMutableArray array];
        
        OpenPageViewController *openPageVC = [[OpenPageViewController alloc] init];
        openPageVC.url = dict[@"url"]
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:openPageVC];
        
        [self presentViewController:nav animated:YES completion:nil];
    }
}

- (void)getContactInfo:(BOOL)isGranted{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if(isGranted){
        NSData *data = [NSJSONSerialization dataWithJSONObject:self.array options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [dict setObject:str forKey:@"contacts"];
        [dict setObject:@(self.array.count) forKey:@"totalCount"];
    }else{
        [dict setObject:@(-1) forKey:@"totalCount"];
    }
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dict];
    [self.commandDelegate sendPluginResult:result callbackId:self.callbackId];
}
@end

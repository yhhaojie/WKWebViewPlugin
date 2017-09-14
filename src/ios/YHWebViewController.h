//
//  YHWebViewController.h
//  WebViewPlugin
//
//  Created by Wiley on 2017/9/11.
//  Copyright © 2017年 MrWiley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHWebViewController : UIViewController

- (instancetype)initWithTitle:(NSString*)title urlStr:(NSString*)urlStr runJsCode:(NSString*)runJsCode;
@end

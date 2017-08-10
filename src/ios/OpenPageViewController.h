//
//  OpenPageViewController.h
//  test
//
//  Created by lv zaiyi on 2017/7/21.
//  Copyright © 2017年 lv zaiyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OpenPageViewControllerDelegate <NSObject>

- (void)popCallback:(NSDictionary *)dict;

@end

@interface OpenPageViewController : UIViewController
@property (nonatomic, copy)NSString *url;
@property (nonatomic, copy)NSString *pageTitle;

- (void)dismissVC;

@end

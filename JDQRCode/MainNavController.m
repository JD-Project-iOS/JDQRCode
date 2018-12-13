//
//  MainNavController.m
//  JDQRCode
//
//  Created by 李伟杰 on 2018/6/26.
//  Copyright © 2018年 李伟杰. All rights reserved.
//

#import "MainNavController.h"
#import "UIImage+streth.h"

@implementation MainNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    //状态栏颜色
    UINavigationBar *nav = [UINavigationBar appearance];
    [nav setBackgroundImage:[UIImage strethImageWith:@"nav_background"] forBarMetrics:UIBarMetricsDefault];
     nav.tintColor = [UIColor whiteColor];
   if ([ UINavigationBar instancesRespondToSelector:@selector (setShadowImage:)]) {
        [[UINavigationBar appearance] setShadowImage:[UIImage imageWithColor:COLOR_RGB(213, 218, 221) size : CGSizeMake( kScreenWidth, 0.5)]];
    }
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    [nav setTitleTextAttributes:textAttrs];
}

- (id)navigationLock {
    return self.topViewController;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController: viewController animated:animated];
}

//防止'Can't add self as subview'崩溃
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated navigationLock:(id)lock; {
    if (!lock || self.topViewController == lock) {
        [self pushViewController:viewController animated:animated];
    }
}

- (id)navigationlock {
    return self.topViewController;
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated navigationLock:(id)lock {
    if (!lock || self.topViewController == lock) {
        [self popToViewController:viewController animated:animated];
    }
    return @[];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated navigationLock:(id)lock {
    if (!lock || self.topViewController == lock) {
        [self popToRootViewControllerAnimated:animated];
    }
    return @[];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

@end

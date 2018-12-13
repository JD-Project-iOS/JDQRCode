//
//  MainNavController.h
///  JDQRCode
//
//  Created by 李伟杰 on 2018/6/26.
//  Copyright © 2018年 李伟杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainNavController : UINavigationController <UINavigationControllerDelegate>

- (id)navigationLock; ///< Obtain "lock" for pushing onto the navigation controller

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated navigationLock:(id)navigationLock; ///< Uses a horizontal slide transition. Has no effect if the view controller is already in the stack. Has no effect if navigationLock is not the current lock.
- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated navigationLock:(id)navigationLock; ///< Pops view controllers until the one specified is on top. Returns the popped controllers. Has no effect if navigationLock is not the current lock.
- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated navigationLock:(id)navigationLock;

@end

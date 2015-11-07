//
//  UINavigationController+AOP.h
//  JiWuAPP
//
//  Created by qianfeng on 15/11/6.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (AOP)

-(void)aop_pushViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end

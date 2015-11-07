//
//  UINavigationController+AOP.m
//  JiWuAPP
//
//  Created by qianfeng on 15/11/6.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "UINavigationController+AOP.h"

#import "NSObject+AOP.h"
#import "LoginController.h"


@implementation UINavigationController (AOP)

+(void)load{
    [self aop_exchangeMethodWithSelector:@selector(pushViewController:animated:) newSelector:@selector(aop_pushViewController:animated:)];
}

-(void)aop_pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    NSArray * titles = @[@"FreshController",@"SecondHandController",@"GroupBuyingController",@"MessageController"];
    NSString * viewControllerClass = NSStringFromClass([viewController class]);
    NSString * userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserName"];
    NSLog(@"%@",userName);
    BOOL isOpen = YES;
    for(NSString * className in titles){
        if([viewControllerClass isEqualToString:className]){
            isOpen = NO;
            if(!userName){
                LoginController * loginController = [[LoginController alloc] initWithNibName:NSStringFromClass([LoginController class]) bundle:nil];
                
                UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:loginController];
                [self presentViewController:navigationController animated:YES completion:nil];
                
            }else{
                
                [self aop_pushViewController:viewController animated:YES];
            }
        }
    }
    if(isOpen){
        
        [self aop_pushViewController:viewController animated:YES];
    }
    
}

@end

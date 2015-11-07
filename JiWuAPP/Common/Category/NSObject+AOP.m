//
//  NSObject+AOP.m
//  JiWuAPP
//
//  Created by qianfeng on 15/11/6.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "NSObject+AOP.h"

#import <objc/runtime.h>

@implementation NSObject (AOP)

+(void)aop_exchangeMethodWithSelector:(SEL)oldSelector newSelector:(SEL)newSelector{
    
    Method newMethod = class_getInstanceMethod([self class], newSelector);
    Method oldMethod = class_getInstanceMethod([self class], oldSelector);
    
    method_exchangeImplementations(oldMethod, newMethod);
}

@end

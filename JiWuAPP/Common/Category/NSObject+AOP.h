//
//  NSObject+AOP.h
//  JiWuAPP
//
//  Created by qianfeng on 15/11/6.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AOP)

+(void)aop_exchangeMethodWithSelector:(SEL)oldSelector newSelector:(SEL)newSelector;

@end

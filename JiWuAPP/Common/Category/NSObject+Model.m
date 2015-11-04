//
//  NSObject+Model.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/22.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "NSObject+Model.h"

@implementation NSObject (Model)

+(id) objectWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}

-(id) initWithDictionary:(NSDictionary *)dict{
    if(self = [self init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end

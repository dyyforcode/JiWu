//
//  SecondHandHouseModel.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "SecondHandHouseModel.h"

#import "NSObject+Model.h"

@implementation SecondHandHouseModel

+(id)secondHandHouseModelWithNode:(id)node{
    return [self objectWithDictionary:node];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if([key isEqualToString:@"id"]){
        _ID = value;
    }
}

@end

//
//  GroupBuyingModel.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/30.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "GroupBuyingModel.h"
#import "NSObject+Model.h"

@implementation GroupBuyingModel


+(id)groupBuyingModelWithNode:(NSDictionary *)node{
    return [self objectWithDictionary:node];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if([key isEqualToString:@"id"]){
        _ID = value;
    }
}

@end

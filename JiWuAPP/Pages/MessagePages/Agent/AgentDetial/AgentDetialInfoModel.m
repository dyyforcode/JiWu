//
//  AgentDetialInfoModel.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/29.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "AgentDetialInfoModel.h"
#import "NSObject+Model.h"

@implementation AgentDetialInfoModel


+(id)agentDetialInfoModelWithNode:(NSDictionary *)node{
    return [self objectWithDictionary:node];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end

//
//  AgentModel.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/28.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "AgentModel.h"

#import "NSObject+Model.h"

@implementation AgentModel

+(id)agentModelWithNode:(NSDictionary *)node{
    return [self objectWithDictionary:node];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end

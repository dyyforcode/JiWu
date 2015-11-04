//
//  HouseTypeModel.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/24.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "HouseTypeModel.h"

#import "NSObject+Model.h"

@implementation HouseTypeModel

+(id)houseTypeModelWithNode:(NSDictionary *)node{
    return [self objectWithDictionary:node];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end

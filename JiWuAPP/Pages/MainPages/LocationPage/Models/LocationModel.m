//
//  LocationModel.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/22.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "LocationModel.h"

#import "NSObject+Model.h"

@implementation LocationModel

+ (id) locationModelWithNode:(id)node{
    return [self objectWithDictionary:node];
}

- (void) setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end

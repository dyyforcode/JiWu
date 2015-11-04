//
//  FeatureChooseModel.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/24.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "FeatureChooseModel.h"

#import "NSObject+Model.h"

@implementation FeatureChooseModel

+(id)featureChooseModelWithNode:(NSDictionary *)node{
    return [self objectWithDictionary:node];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if([key isEqualToString:@"id"]){
        _ID = value;
    }
}

@end

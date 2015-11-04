//
//  MainHouseModel.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/22.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "MainHouseModel.h"

#import "NSObject+Model.h"

@implementation MainHouseModel

+(id)mainHouseModelWithDictionary:(NSDictionary *)dictionary{
    return [self objectWithDictionary:dictionary];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if([key isEqualToString:@"id"]){
        _ID = value;
    }
}

@end


@implementation LocalPriceModel

+(id) localPriceModelWithDictionary:(NSDictionary *)dict{
    return [self objectWithDictionary:dict];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end

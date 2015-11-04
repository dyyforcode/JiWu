//
//  HouseDetialModel.m
//  JiWuAPP
//
//  Created by qianfeng on 15/10/24.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import "HouseDetialModel.h"
#import "NSObject+Model.h"


@implementation HouseDetialImageModel

+(id)houseDetialImageModelWithNode:(NSDictionary *)node{
    return [self objectWithDictionary:node];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end






@implementation HouseDetialHouseTypeModel

+(id)houseDetialHouseTypeModelWithNode:(NSDictionary *)node{
    return [self objectWithDictionary:node];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end






@implementation HouseDetialModel

+(id)HouseDetialModelWithNode:(NSDictionary *)node{
    return [self objectWithDictionary:node];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if([key isEqualToString:@"id"]){
        _ID = value;
    }else if([key isEqualToString:@"buildImgs"]){
        NSMutableArray * imagesArray = [NSMutableArray new];
        for(NSDictionary * dict in value){
            HouseDetialImageModel * imageModel = [HouseDetialImageModel houseDetialImageModelWithNode:dict];
            [imagesArray addObject:imageModel];
        }
        self.buildImgsArray = imagesArray;
    }else if([key isEqualToString:@"houseTypes"]){
        NSMutableArray * houseTypeArray = [NSMutableArray new];
        for(NSDictionary * dict in value){
            HouseDetialHouseTypeModel * houseTypeModel = [HouseDetialHouseTypeModel houseDetialHouseTypeModelWithNode:dict];
            [houseTypeArray addObject:houseTypeModel];
        }
        self.houseTypesArray = houseTypeArray;
    }
}

@end

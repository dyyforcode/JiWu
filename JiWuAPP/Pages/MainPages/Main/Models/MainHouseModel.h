//
//  MainHouseModel.h
//  JiWuAPP
//
//  Created by qianfeng on 15/10/22.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainHouseModel : NSObject

@property (nonatomic) NSString * status;
@property (nonatomic) NSString * plate;
@property (nonatomic) NSString * discountPrice;
@property (nonatomic) NSString * label;
@property (nonatomic) NSString * openTime;
@property (nonatomic) NSString * ID;
@property (nonatomic) NSString * price;
@property (nonatomic) NSString * area;
@property (nonatomic) NSString * address;
@property (nonatomic) NSString * name;
@property (nonatomic) NSString * path;
@property (nonatomic) NSString * features;
@property (nonatomic) NSString * longitude;
@property (nonatomic) NSString * latitude;
@property (nonatomic) NSString * grouponInfo;

+(id)mainHouseModelWithDictionary:(NSDictionary *)dictionary;

@end


@interface LocalPriceModel : NSObject

@property (nonatomic) NSString * hasGroupon;
@property (nonatomic) NSString * agentEnough;
@property (nonatomic) NSString * range;
@property (nonatomic) NSString * averPrice;

+(id)localPriceModelWithDictionary:(NSDictionary *)dict;

@end

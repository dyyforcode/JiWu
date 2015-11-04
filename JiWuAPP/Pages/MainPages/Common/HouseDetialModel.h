//
//  HouseDetialModel.h
//  JiWuAPP
//
//  Created by qianfeng on 15/10/24.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HouseDetialImageModel : NSObject

@property (nonatomic,copy)NSString * name;
@property (nonatomic,copy)NSArray * imgArray;

+(id)houseDetialImageModelWithNode:(NSDictionary *)node;

@end





@interface HouseDetialHouseTypeModel : NSObject

@property (nonatomic,copy) NSString * typeName;
@property (nonatomic,copy) NSString * area;
@property (nonatomic,copy) NSString * path;

+(id)houseDetialHouseTypeModelWithNode:(NSDictionary *)node;

@end





@interface HouseDetialModel : NSObject

@property (nonatomic,copy) NSString * house;
@property (nonatomic,copy) NSString * favorContent;
@property (nonatomic,copy) NSString * longitude;
@property (nonatomic,copy) NSString * bank;
@property (nonatomic,copy) NSString * goldAgent;
@property (nonatomic,copy) NSString * orientation;
@property (nonatomic,copy) NSString * others;
@property (nonatomic,copy) NSString * status;
@property (nonatomic,copy) NSString * favorTitle;
@property (nonatomic,copy) NSString * orderOpen;
@property (nonatomic,copy) NSString * buildYear;
@property (nonatomic,copy) NSString * hotSaleTime;
@property (nonatomic,copy) NSString * shareUrl;
@property (nonatomic,copy) NSString * latitude;
@property (nonatomic,copy) NSString * shopping;
@property (nonatomic,copy) NSString * grouponInfo;
@property (nonatomic,copy) NSString * hospital;
@property (nonatomic,copy) NSString * busLine;

@property (nonatomic,copy) NSString * ID;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * price;
@property (nonatomic,copy) NSString * openTime;
@property (nonatomic,copy) NSString * address;
@property (nonatomic,copy) NSString * salePhone;
@property (nonatomic,copy) NSString * hotSaleContent;
@property (nonatomic,copy) NSString * hotSaleTitle;
@property (nonatomic,copy) NSString * locPath;
@property (nonatomic,copy) NSString * label;
@property (nonatomic,copy) NSString * liveTime;
@property (nonatomic,copy) NSString * buildStatus;
@property (nonatomic,copy) NSString * volumePercent;
@property (nonatomic,copy) NSString * greenPercent;
@property (nonatomic,copy) NSString * propFees;
@property (nonatomic,copy) NSString * planOwnerCount;
@property (nonatomic,copy) NSString * planArea;
@property (nonatomic,copy) NSString * buildArea;
@property (nonatomic,copy) NSString * parking;
@property (nonatomic,copy) NSString * propCompany;
@property (nonatomic,copy) NSString * propType;
@property (nonatomic,copy) NSString * buildType;
@property (nonatomic,copy) NSString * developers;
@property (nonatomic,copy) NSString * propRight;

@property (nonatomic,copy) NSString * cooperHouse;
@property (nonatomic,copy) NSString * path;
@property (nonatomic,copy) NSString * grouponId;
@property (nonatomic,copy) NSString * saleAgency;
@property (nonatomic,copy) NSString * school;
@property (nonatomic,copy) NSString * foods;
@property (nonatomic,copy) NSString * grouponPer;

@property (nonatomic,copy) NSArray * buildImgsArray;
@property (nonatomic,copy) NSArray * houseTypesArray;

+(id)HouseDetialModelWithNode:(NSDictionary *)node;


@end

























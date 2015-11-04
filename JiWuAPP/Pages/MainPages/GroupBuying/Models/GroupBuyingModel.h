//
//  GroupBuyingModel.h
//  JiWuAPP
//
//  Created by qianfeng on 15/10/30.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupBuyingModel : NSObject


@property (nonatomic,copy) NSString * status;
@property (nonatomic,copy) NSString * plate;
@property (nonatomic,copy) NSString * grouponId;
@property (nonatomic,copy) NSString * discountPrice;
@property (nonatomic,copy) NSString * openTime;
@property (nonatomic,copy) NSString * label;

@property (nonatomic,copy) NSString * ID;
@property (nonatomic,copy) NSString * price;
@property (nonatomic,copy) NSString * area;
@property (nonatomic,copy) NSString * address;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * path;

@property (nonatomic,copy) NSString * features;
@property (nonatomic,copy) NSString * paticipater;
@property (nonatomic,copy) NSString * grouponInfo;


+(id)groupBuyingModelWithNode:(NSDictionary *)node;

@end

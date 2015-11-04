//
//  GroupBuyingDetialModel.h
//  JiWuAPP
//
//  Created by qianfeng on 15/10/30.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupBuyingDetialModel : NSObject

@property (nonatomic,copy) NSString * locPath;
@property (nonatomic,copy) NSString * status;
@property (nonatomic,copy) NSString * openTime;
@property (nonatomic,copy) NSString * validDeadline;
@property (nonatomic,copy) NSString * salePhone;
@property (nonatomic,copy) NSString * buildImgs;

@property (nonatomic,copy) NSString * grouponTitle;
@property (nonatomic,copy) NSString * ID;
@property (nonatomic,copy) NSString * applyDeadLine;
@property (nonatomic,copy) NSString * price;
@property (nonatomic,copy) NSString * address;
@property (nonatomic,copy) NSString * name;

@property (nonatomic,copy) NSString * joinedCount;
@property (nonatomic,copy) NSString * path;
@property (nonatomic,copy) NSString * shareUrl;
@property (nonatomic,copy) NSString * longitude;
@property (nonatomic,copy) NSString * latitude;
@property (nonatomic,copy) NSString * grouponDetail;

+(id)groupBuyingDetialModelWithNode:(NSDictionary *)node;


@end

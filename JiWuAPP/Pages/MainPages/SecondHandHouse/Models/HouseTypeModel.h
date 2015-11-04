//
//  HouseTypeModel.h
//  JiWuAPP
//
//  Created by qianfeng on 15/10/24.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HouseTypeModel : NSObject

@property (nonatomic,copy) NSString * houseTypeId;
@property (nonatomic,copy) NSString * houseTypeName;

+(id)houseTypeModelWithNode:(NSDictionary *)node;

@end

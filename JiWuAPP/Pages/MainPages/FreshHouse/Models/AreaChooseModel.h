//
//  AreaChooseModel.h
//  JiWuAPP
//
//  Created by qianfeng on 15/10/24.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AreaChooseModel : NSObject

@property (nonatomic,copy) NSString * areaName;
@property (nonatomic,copy) NSString * cityId;
@property (nonatomic,copy) NSString * areaId;
@property (nonatomic,copy) NSArray * plateArray;

+(id)areaChooseModelWidthNode:(NSDictionary *)node;

@end

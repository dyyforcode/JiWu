//
//  SecondHandHouseModel.h
//  JiWuAPP
//
//  Created by qianfeng on 15/10/23.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecondHandHouseModel : NSObject

@property (nonatomic) NSString * ID;
@property (nonatomic) NSString * title;
@property (nonatomic) NSString * buildName;
@property (nonatomic) NSString * price;
@property (nonatomic) NSString * areaName;
@property (nonatomic) NSString * buildId;
@property (nonatomic) NSString * plateName;
@property (nonatomic) NSString * name;
@property (nonatomic) NSString * path;
@property (nonatomic) NSString * longitude;
@property (nonatomic) NSString * latitude;

+(id)secondHandHouseModelWithNode:(id)node;

@end

//
//  DataBaseManager.h
//  JiWuAPP
//
//  Created by qianfeng on 15/11/4.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HouseDetialModel;

@interface DataBaseManager : NSObject



+(instancetype)shareManager;

-(BOOL)insertAttentionHouseInfo:(HouseDetialModel *)houseModel cityName:(NSString *)cityName;

-(BOOL)removeAttentionHouseInfo:(NSString *)houseId;

-(NSArray *)selectAttentionHouse;

@end

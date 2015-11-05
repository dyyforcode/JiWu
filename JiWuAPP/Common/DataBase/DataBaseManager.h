//
//  DataBaseManager.h
//  JiWuAPP
//
//  Created by qianfeng on 15/11/4.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MainHouseModel;

@interface DataBaseManager : NSObject

+(instancetype)shareManager;

-(BOOL)insertFindHouseInfo:(MainHouseModel *)houseMoidel;

@end

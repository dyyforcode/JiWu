//
//  NetInterface.h
//  JiWuAPP
//
//  Created by qianfeng on 15/10/22.
//  Copyright (c) 2015年 myOwn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetInterface : NSObject

+(NSString *)locationServerPath;
+(NSString *)locationCachePath;

+(NSString *)freshHouseServerPath;
+(NSString *)freshHouseCachePath;

+(NSString *)secondHandHouseServerPath;
+(NSString *)secondHandHouseCachePath;

+(NSString *)localPriceServerPath;
+(NSString *)localPriceCachePath;

+(NSString *)hotHouseServerPath;
+(NSString *)hotHouseCachePath;

+(NSString *)agentServerPath;
+(NSString *)agentCachePath;

+(NSString *)helpMeFindServerPath;

@end
